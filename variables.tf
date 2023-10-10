variable "google_provider_credential_file" {
  description = "The path to the GCP service account credential file"
  type        = string
}

variable "helm_chart_repository" {
  type    = string
  default = "https://sliderule-public.github.io/helm-charts/"
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "web_url" {
  description = "The desired  URL of the web application"
  type        = string
}

variable "api_url" {
  description = "The desired URL of the API"
  type        = string
}

variable "grpc_url" {
  description = "The desired URL of the gRPC API"
  type        = string
}

variable "environment" {
  description = "The environment to deploy to"
  type        = string
}

variable "api_image_url" {
  description = "The URL of the API docker image"
  type        = string
}

variable "web_image_url" {
  description = "The URL of the web docker image"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy to"
  type        = string
  default     = "us-central1"
}
variable "enable_prometheus" {
  description = "Enable Prometheus monitoring of the API"
  type        = bool
  default     = false
}

variable "cert_dir" {
  description = "The directory to contain GCP DB certificates"
  type        = string
  default     = ".ignore"
}