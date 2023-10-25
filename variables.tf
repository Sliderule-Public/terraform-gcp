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

variable "network_id" {
  description = "The ID of the GCP network to deploy to. If empty, a network will be deployed."
  type        = string
  default     = ""
}

variable "kubernetes_cluster_name" {
  description = "The name of the Kubernetes cluster to deploy to. If empty, a cluster will be deployed."
  type        = string
  default     = ""
}
variable "db_authorized_networks" {
  description = "List of authorized networks for DB access"
  type        = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "deploy_helm_prereqs" {
  description = "Deploy the helm prereqs, currently consisting of the External Secrets operator"
  type        = bool
  default     = true
}
variable "service_node_ports" {
  description = "Node ports to expose for the services"
  type        = map(string)
  default     = {
    api = "31257"
    web = "31255"
  }
}

variable "api_secret_name" {
  description = "The name of the GCP secret containing API information"
  type        = string
}

variable "web_secret_name" {
  description = "The name of the GCP secret containing web information"
  type        = string
}

variable "api_task_initial_count" {
  description = "The number of initial API tasks to start"
  type        = number
  default     = 1
}

variable "web_task_initial_count" {
  description = "The number of initial web tasks to start"
  type        = number
  default     = 1
}

variable "vpc_cidr" {
  description = "The CIDR of the VPC to deploy to"
  type        = string
  default     = "10.200.0.0/16"
}

variable create_private_services_connection {
  description = "Create a private services connection to the cluster"
  type        = bool
  default     = false
}