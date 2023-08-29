module "gke_cluster" {
  source       = "./modules/gke"
  app_name     = local.app_name
  project_id   = var.project_id
  environment  = var.environment
  location     = var.region
  network_name = module.compute_network.network_name
}