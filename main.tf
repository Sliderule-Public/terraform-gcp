provider "google" {
  region      = var.region
  credentials = file(var.google_provider_credential_file)
}

provider "google-beta" {
  region      = var.region
  credentials = file(var.google_provider_credential_file)
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
      version = ">= 2.19.0"
    }

    google = {
      version = ">= 4.61.0"
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

provider "helm" {
  kubernetes {
    host                   = "https://${module.gke_cluster.cluster.endpoint}"
    token                  = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(
      module.gke_cluster.cluster.master_auth[0].cluster_ca_certificate
    )
    client_certificate = base64decode(
      module.gke_cluster.cluster.master_auth[0].client_certificate
    )
    client_key = base64decode(
      module.gke_cluster.cluster.master_auth[0].client_key
    )
  }
}

provider "kubernetes" {
  host                   = "https://${module.gke_cluster.cluster.endpoint}"
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    module.gke_cluster.cluster.master_auth[0].cluster_ca_certificate
  )
}