resource "google_compute_global_address" "web" {
  name    = "shieldrule-web"
  project = var.project_id
}

resource "google_compute_global_address" "api" {
  name    = "shieldrule-api"
  project = var.project_id
}

resource "helm_release" "prerequisites" {
  depends_on = [
    kubernetes_secret.sliderule,
    google_compute_global_address.web,
    google_compute_global_address.api,
    module.gke_cluster,
    kubernetes_namespace.sliderule,
    kubernetes_namespace.sliderule_prerequisites,
  ]
  name       = "prerequisites-gcp"
  repository = var.helm_chart_repository
  chart      = "prerequisites-gcp"
  version    = "0.1.2"
  namespace  = local.sliderule_namespace
  wait       = true

  set {
    name  = "external-secrets.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "external-secrets.rbac.create"
    value = "true"
  }

  set {
    name  = "external-secrets.serviceAccount.annotations.iam\\.gke\\.io/gcp-service-account"
    value = google_service_account.sliderule.email
  }
}

resource "null_resource" "allow_prerequisites_to_build_crds" {
  depends_on = [
    helm_release.prerequisites
  ]
}

resource "time_sleep" "allow_prerequisites_to_build_crds" {
  depends_on = [null_resource.allow_prerequisites_to_build_crds]

  create_duration = "10s"
}

resource "helm_release" "secrets" {
  depends_on = [time_sleep.allow_prerequisites_to_build_crds]
  name       = "sliderulesecrets"
  repository = var.helm_chart_repository
  chart      = "sliderule-secrets"
  version    = "0.3.1"
  namespace  = local.sliderule_namespace
  wait       = true

  set {
    name  = "project_id"
    value = var.project_id
  }

  set {
    name  = "cluster_location"
    value = var.region
  }

  set {
    name  = "cluster_name"
    value = module.gke_cluster.cluster.name
  }

  set {
    name  = "namespace"
    value = local.sliderule_namespace
  }

  set {
    name  = "target_namespace"
    value = local.sliderule_namespace
  }
}

resource "null_resource" "allow_secrets_to_populate" {
  depends_on = [
    helm_release.secrets
  ]
}

resource "time_sleep" "allow_secrets_to_populate" {
  depends_on = [null_resource.allow_secrets_to_populate]

  create_duration = "10s"
}

resource "helm_release" "sliderule_base" {
  depends_on = [time_sleep.allow_secrets_to_populate]
  name       = "sliderule-base"
  repository = var.helm_chart_repository
  chart      = "sliderule-base"
  version    = "0.8.15"
  namespace  = local.sliderule_namespace
  wait       = false

  values = [
    templatefile("${path.module}/helm_templates/sliderule_base.yaml", {
      api_service_account_name : local.service_account_name
      gcp_service_account : local.service_account_email
      enable_prometheus : var.enable_prometheus
      api_image_url : var.api_image_url
      web_image_url : var.web_image_url
      SHIELDRULE_ENVIRONMENT : var.environment
    })
  ]
}

resource "null_resource" "allow_base_to_deploy" {
  depends_on = [
    helm_release.sliderule_base
  ]
}

resource "time_sleep" "allow_base_to_deploy" {
  depends_on = [null_resource.allow_base_to_deploy]

  create_duration = "10s"
}

resource "helm_release" "sliderule" {
  depends_on = [time_sleep.allow_secrets_to_populate]
  name       = "sliderule-gcp"
  repository = var.helm_chart_repository
  chart      = "sliderule-gcp"
  version    = "0.5.3"
  namespace  = local.sliderule_namespace
  wait       = false

  set {
    name  = "web_url"
    value = var.web_url
  }

  set {
    name  = "api_url"
    value = var.api_url
  }

  set {
    name  = "grpc_url"
    value = var.grpc_url
  }
}

resource "kubernetes_secret" "sliderule" {
  depends_on = [kubernetes_namespace.sliderule, module.database, module.main_pub_sub_topic]
  metadata {
    name      = "terraform-secret"
    namespace = "sliderule-${var.environment}"
  }

  data = {
    PUB_SUB_TOPIC_ID               = module.main_pub_sub_topic.topic_id
    POSTGRES_DB                    = "${local.app_name}-${var.environment}-main"
    POSTGRES_HOST                  = module.database.private_ip_address
    POSTGRES_PORT                  = 5432
    SHIELDRULE_ENVIRONMENT         = var.environment
    METRICS_NAMESPACE              = var.environment
    REDIS_HOST                     = google_redis_instance.main.host
    REDIS_PORT                     = 6379
    GCP_BUCKET_NAME                = module.application_storage_bucket.bucket_name
    GCP_PROJECT_ID                 = var.project_id
    GCP_PERSIST_QUEUE_TOPIC        = module.main_pub_sub_topic.topic_name
    GCP_PERSIST_QUEUE_SUBSCRIPTION = module.main_pub_sub_topic.subscription_name
  }
}

resource "kubernetes_namespace" "sliderule" {
  metadata {
    annotations = {
      name = local.sliderule_namespace
    }

    name = local.sliderule_namespace
  }
}

resource "kubernetes_namespace" "sliderule_prerequisites" {
  metadata {
    annotations = {
      name = local.prerequisite_namespace
    }

    name = local.prerequisite_namespace
  }
}

resource "kubernetes_config_map" "gcp_db_cert" {
  metadata {
    name      = "gcp-db-cert-info"
    namespace = local.sliderule_namespace
  }

  data = {
    "root-cert"   = module.database.root_cert
    "client-cert" = module.database.client_cert
  }

  binary_data = {
    "client-key" = module.database.client_key
  }
}