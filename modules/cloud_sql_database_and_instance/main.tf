locals {
  name_prefix = "${var.app_name}-${var.environment}"
}

resource "google_sql_database" "database" {
  name     = "${local.name_prefix}-${var.db_name}"
  instance = google_sql_database_instance.instance.name
  project  = var.project_id
}

resource "google_sql_database_instance" "instance" {
  provider         = google-beta
  name             = "${local.name_prefix}-${var.db_name}"
  database_version = var.db_version
  project          = var.project_id
  region           = var.region

  settings {
    tier = var.db_tier

    ip_configuration {
      ipv4_enabled    = true
      private_network = var.network_id
      require_ssl     = true

      dynamic "authorized_networks" {
        for_each = var.db_authorized_networks
        content {
          name  = authorized_networks.value.name
          value = authorized_networks.value.value
        }
      }
    }
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "google_compute_global_address" "private_ip_address" {
  count    = var.create_private_services_connection ? 1 : 0
  provider = google-beta

  name          = "${local.name_prefix}-private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  project       = var.project_id
  network       = var.network_id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  count    = var.create_private_services_connection ? 1 : 0
  provider = google-beta

  network                 = var.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address[0].name]
}


data "google_secret_manager_secret_version" "sliderule" {
  secret  = var.api_secret_name
  project = var.project_id
}

locals {
  secret_variables = jsondecode(data.google_secret_manager_secret_version.sliderule.secret_data)
}

resource "google_sql_user" "users" {
  name     = local.secret_variables.POSTGRES_USER
  instance = google_sql_database_instance.instance.name
  password = local.secret_variables.POSTGRES_PASSWORD
  project  = var.project_id
}

resource "google_sql_ssl_cert" "client_cert" {
  common_name = "${local.name_prefix}-${var.db_name}"
  instance    = google_sql_database_instance.instance.name
  project     = var.project_id
}
