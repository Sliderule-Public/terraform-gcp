module "application_storage_bucket" {
  source      = "./modules/storage_bucket"
  app_name    = local.app_name
  environment = var.environment
  project_id  = var.project_id
  bucket_name = "sliderule_storage"
}