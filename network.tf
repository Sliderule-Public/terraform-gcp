module "compute_network" {
  count       = var.network_id == "" ? 1 : 0
  source      = "modules/compute_network"
  app_name    = local.app_name
  environment = local.environment
  project_id  = var.project_id
  vpc_cidr    = var.vpc_cidr
  region      = var.region
}