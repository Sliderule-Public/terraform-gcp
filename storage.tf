module "application_storage_bucket" {
  source      = "./modules/storage_bucket"
  app_name    = local.app_name
  environment = local.environment
  project_id  = var.project_id
  bucket_name = "shieldrule_storage"
  web_url     = var.web_url
}