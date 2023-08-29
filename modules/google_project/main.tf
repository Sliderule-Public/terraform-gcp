locals {
  name_prefix = "${var.app_name}-${var.environment}"
}

resource "google_project" "project" {
  name            = "${local.name_prefix}-proj"
  project_id      = "${local.name_prefix}-proj"
  org_id          = var.org_id
  billing_account = var.billing_account
}