module "compute_network" {
  source      = "./modules/compute_network"
  app_name    = local.app_name
  environment = var.environment
  project_id  = var.project_id
}