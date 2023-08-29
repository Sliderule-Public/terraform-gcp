output "private_ip_address" {
  value = google_sql_database_instance.instance.private_ip_address
}

output "certificate" {
  value = google_sql_ssl_cert.client_cert.cert
}

output "private_key" {
  value = google_sql_ssl_cert.client_cert.private_key
}