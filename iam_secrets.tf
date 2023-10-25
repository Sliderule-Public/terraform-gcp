resource "google_service_account" "sliderule_secrets" {
  project      = var.project_id
  account_id   = local.secrets_service_account_name
  display_name = local.secrets_service_account_name
}

resource "google_project_iam_member" "secret_admin" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.sliderule_secrets.email}"
}

resource "google_service_account_iam_member" "secrets_identity" {
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${local.prerequisite_namespace}/${local.secrets_service_account_name}]"
  service_account_id = google_service_account.sliderule_secrets.name
}