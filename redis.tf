resource "google_redis_instance" "main" {
  project        = var.project_id
  name           = "${local.name_prefix}-${local.app_name}"
  tier           = "STANDARD_HA"
  memory_size_gb = 10

  location_id             = "${var.region}-a"
  alternative_location_id = "${var.region}-b"

  authorized_network = local.network_id

  redis_version = "REDIS_6_X"
  display_name  = local.app_name

  redis_configs = {
    "maxmemory-policy" = "allkeys-lru"
  }

  maintenance_policy {
    weekly_maintenance_window {
      day = "TUESDAY"
      start_time {
        hours   = 0
        minutes = 30
        seconds = 0
        nanos   = 0
      }
    }
  }
}