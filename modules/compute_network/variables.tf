variable "environment" {
  type = string
}
variable "app_name" {
  type = string
}
variable "project_id" {
  type = string
}
variable "vpc_cidr" {
  description = "The CIDR of the VPC to deploy to"
  type        = string
}
variable "region" {
  description = "The region to deploy to"
  type        = string
}