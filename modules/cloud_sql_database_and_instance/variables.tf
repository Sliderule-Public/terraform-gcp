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