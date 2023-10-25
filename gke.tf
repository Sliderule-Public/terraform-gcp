module "gke_cluster" {
  count        = var.kubernetes_cluster_name == "" ? 1 : 0
  source       = "../src/modules/simple/gke"
  app_name     = local.app_name
  project_id   = var.project_id
  environment  = local.environment
  location     = local.region
  network_name = local.network_id
}