locals {
  environment            = var.environment
  app_name               = "shieldrule"
  name_prefix            = "${local.app_name}-${local.environment}"
  region                 = "us-central1"
  prerequisite_namespace = "sliderule-${local.environment}-prerequisites"
  sliderule_namespace    = "sliderule-${local.environment}"
  service_account_name   = "sliderule-sa"
  service_account_email  = "${local.service_account_name}@${var.project_id}.iam.gserviceaccount.com"
}