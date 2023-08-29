locals {
  app_name               = "sliderule"
  name_prefix            = "${local.app_name}-${var.environment}"
  prerequisite_namespace = "sliderule-${var.environment}-prerequisites"
  sliderule_namespace    = "sliderule-${var.environment}"
  service_account_email  = "${var.service_account_name}@${var.project_id}.iam.gserviceaccount.com"
}