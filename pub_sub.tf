module "main_pub_sub_topic" {
  source      = "./modules/pub_sub"
  app_name    = local.app_name
  environment = var.environment
  topic_name  = "main"
  project_id  = var.project_id
}