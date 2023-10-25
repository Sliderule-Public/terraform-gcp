locals {
  name_prefix   = "${var.app_name}-${var.environment}"
  subnet_a_cidr = cidrsubnet(var.vpc_cidr, 4, 0)
  subnet_b_cidr = cidrsubnet(var.vpc_cidr, 4, 1)
  subnet_c_cidr = cidrsubnet(var.vpc_cidr, 4, 2)
}

resource "google_compute_network" "vpc" {
  name    = local.name_prefix
  project = var.project_id
}

module "vpc" {
  source = "terraform-google-modules/network/google"

  project_id   = var.project_id
  network_name = "${local.name_prefix}-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "${local.name_prefix}-subnet-a"
      subnet_ip             = local.subnet_a_cidr
      subnet_region         = var.region
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = "${local.name_prefix}-subnet-b"
      subnet_ip             = local.subnet_b_cidr
      subnet_region         = var.region
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = "${local.name_prefix}-subnet-c"
      subnet_ip             = local.subnet_c_cidr
      subnet_region         = var.region
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    }
  ]

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]
}

module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  name    = local.name_prefix
  project = var.project_id
  network = module.vpc.network_name
  region  = var.region

  nats = [
    {
      name                               = local.name_prefix
      source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
      subnetworks                        = [
        {
          name                    = module.vpc.subnets["${var.region}/${local.name_prefix}-subnet-a"].id
          source_ip_ranges_to_nat = ["PRIMARY_IP_RANGE"]
        },
        {
          name                    = module.vpc.subnets["${var.region}/${local.name_prefix}-subnet-b"].id
          source_ip_ranges_to_nat = ["PRIMARY_IP_RANGE"]
        },
        {
          name                    = module.vpc.subnets["${var.region}/${local.name_prefix}-subnet-c"].id
          source_ip_ranges_to_nat = ["PRIMARY_IP_RANGE"]
        }
      ]
    }
  ]
}