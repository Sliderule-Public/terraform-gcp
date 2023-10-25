module "database" {
  source                             = "../src/modules/simple/cloud_sql_database_and_instance"
  app_name                           = local.app_name
  environment                        = local.environment
  project_id                         = var.project_id
  db_name                            = "main"
  network_id                         = local.network_id
  region                             = local.region
  db_authorized_networks             = var.db_authorized_networks
  api_secret_name                    = var.api_secret_name
  create_private_services_connection = var.create_private_services_connection
}