locals {
  environment                  = var.environment
  app_name                     = "shieldrule"
  name_prefix                  = "${local.app_name}-${local.environment}"
  region                       = "us-central1"
  prerequisite_namespace       = "sliderule-${local.environment}-prerequisites"
  sliderule_namespace          = "sliderule-${local.environment}"
  service_account_name         = local.name_prefix
  secrets_service_account_name = substr("${local.name_prefix}-secrets", 0, 28)
  service_account_email        = "${local.service_account_name}@${var.project_id}.iam.gserviceaccount.com"
  network_id                   = var.network_id != "" ? var.network_id : module.compute_network[0].network_id
  cluster_name                 = var.kubernetes_cluster_name != "" ? var.kubernetes_cluster_name : module.gke_cluster[0].cluster.name
}