variable "helm_chart_repository" {
  type    = string
  default = "https://sliderule-public.github.io/helm-charts/"
}

variable "project_id" {
  type = string
}

variable "google_provider_credential_file" {
  type = string
}

variable "region" {
  type = string
  default = "us-central1"
}

variable "web_url" {
  type = string
}

variable "api_url" {
  type = string
}

variable "grpc_url" {
  type = string
}

variable "service_account_name" {
  type    = string
  default = ""
}

variable "environment" {
  type = string
}

variable "api_image_url" {
  type = string
}

variable "web_image_url" {
  type = string
}