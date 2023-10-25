provider "google" {
  region      = "us-central1"
  credentials = file("~/sliderule-dev-a65ff69fe82d.json")
}

provider "google-beta" {
  region      = "us-central1"
  credentials = file("~/sliderule-dev-a65ff69fe82d.json")
}

data "google_client_config" "provider" {}

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }

    helm = {
      version = ">= 2.9.0"
    }

    kubernetes = {
      version = "2.19.0"
    }

    google = {
      version = "< 5.0.0"
    }

    google-beta = {
      version = ">= 4.61.0"
    }

    time = {
      version = ">= 0.9.1"
    }

    null = {
      version = ">= 3.2.1"
    }
  }

  required_version = ">= 1.3.2"
}

data "google_container_cluster" "sliderule" {
  depends_on = [module.gke_cluster]
  name       = var.kubernetes_cluster_name != "" ? var.kubernetes_cluster_name : module.gke_cluster[0].cluster.name
  location   = local.region
  project    = var.project_id
}

provider "helm" {
  kubernetes {
    host                   = "https://${data.google_container_cluster.sliderule.endpoint}"
    token                  = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(
      data.google_container_cluster.sliderule.master_auth[0].cluster_ca_certificate
    )
    client_certificate = base64decode(
      data.google_container_cluster.sliderule.master_auth[0].client_certificate
    )
    client_key = base64decode(
      data.google_container_cluster.sliderule.master_auth[0].client_key
    )
  }
}

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.sliderule.endpoint}"
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.sliderule.master_auth[0].cluster_ca_certificate
  )
  client_certificate = base64decode(
    data.google_container_cluster.sliderule.master_auth[0].client_certificate
  )
  client_key = base64decode(
    data.google_container_cluster.sliderule.master_auth[0].client_key
  )
}