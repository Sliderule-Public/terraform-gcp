module "kms_key_main" {
  source      = "./modules/kms_crypto_key"
  app_name    = local.app_name
  environment = var.environment
  project_id  = var.project_id
}