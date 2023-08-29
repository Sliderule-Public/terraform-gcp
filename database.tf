module "database" {
  source      = "./modules/cloud_sql_database_and_instance"
  app_name    = local.app_name
  environment = var.environment
  project_id  = var.project_id
  db_name     = "main"
  network_id  = module.compute_network.network_id
  region      = var.region
}