resource "google_service_account" "sliderule" {
  project      = var.project_id
  account_id   = "sliderule-sa"
  display_name = local.service_account_name
}

resource "google_project_iam_member" "secretadmin" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.sliderule.email}"
}

resource "google_project_iam_member" "bucket_creator" {
  project = var.project_id
  role    = "roles/storage.objectCreator"
  member  = "serviceAccount:${google_service_account.sliderule.email}"
}

resource "google_project_iam_member" "bucket_user" {
  project = var.project_id
  role    = "roles/storage.objectUser"
  member  = "serviceAccount:${google_service_account.sliderule.email}"
}

resource "google_project_iam_member" "bucket_viewer" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.sliderule.email}"
}

resource "google_project_iam_member" "pubsub_subscriber" {
  project = var.project_id
  role    = "roles/pubsub.subscriber"
  member  = "serviceAccount:${google_service_account.sliderule.email}"
}

resource "google_project_iam_member" "pubsub_publisher" {
  project = var.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${google_service_account.sliderule.email}"
}

resource "google_project_iam_member" "pubsub_viewer" {
  project = var.project_id
  role    = "roles/pubsub.viewer"
  member  = "serviceAccount:${google_service_account.sliderule.email}"
}

resource "google_project_iam_member" "service_account_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.sliderule.email}"
}

resource "google_service_account_iam_member" "pod_identity" {
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[sliderule-${local.environment}/${local.service_account_name}]"
  service_account_id = google_service_account.sliderule.name
}