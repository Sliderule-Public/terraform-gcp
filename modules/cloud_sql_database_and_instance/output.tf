output "private_ip_address" {
  value = google_sql_database_instance.instance.private_ip_address
}

output "client_cert" {
  value = google_sql_ssl_cert.client_cert.cert
}

output "client_key" {
  value = google_sql_ssl_cert.client_cert.private_key
}

output "root_cert" {
  value = google_sql_ssl_cert.client_cert.server_ca_cert
}