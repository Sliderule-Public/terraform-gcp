output "network_id" {
  value = google_compute_network.vpc.id
}
output "network_name" {
  value = google_compute_network.vpc.name
}
output "network_gateway_ip" {
  value = google_compute_network.vpc.gateway_ipv4
}