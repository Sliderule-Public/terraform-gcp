variable "environment" {
  type = string
}
variable "app_name" {
  type = string
}
variable "project_id" {
  type = string
}
variable "db_name" {
  type = string
}
variable "region" {
  type = string
}
variable "db_tier" {
  type    = string
  default = "db-g1-small"
}
variable "db_version" {
  type    = string
  default = "POSTGRES_11"
}
variable "network_id" {
  type = string
}
variable "cert_dir" {
  description = "The directory to contain GCP DB certificates"
  type        = string
  default     = ".ignore"
}
variable "db_authorized_networks" {
  description = "List of authorized networks for DB access"
  type        = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "api_secret_name" {
  description = "The name of the GCP secret containing API information"
  type        = string
}

variable create_private_services_connection {
  description = "Create a private services connection to the cluster"
  type        = bool
}