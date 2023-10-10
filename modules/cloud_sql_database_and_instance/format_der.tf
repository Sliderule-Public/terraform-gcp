# Found here: https://github.com/hashicorp/terraform-provider-tls/issues/36
# Converts the pem to the der format needed by the JVM

locals {
  key_dir = var.cert_dir
}

resource "local_file" "key_pem" {
  content  = google_sql_ssl_cert.client_cert.private_key
  filename = "${local.key_dir}/key.pem"
}

resource "null_resource" "pem_to_der" {
  depends_on = [
    local_file.key_pem
  ]

  provisioner "local-exec" {
    command = "openssl pkcs8 -topk8 -nocrypt -inform PEM -in ${local.key_dir}/key.pem -outform DER -out ${local.key_dir}/key.der"
  }
}

data "local_file" "key_pk8" {
  filename = "${local.key_dir}/key.der"

  depends_on = [
    null_resource.pem_to_der
  ]
}

resource "local_file" "cert" {
  content  = google_sql_ssl_cert.client_cert.server_ca_cert
  filename = "${local.key_dir}/cert.pem"
}

resource "local_file" "client_cert" {
  content  = google_sql_ssl_cert.client_cert.cert
  filename = "${local.key_dir}/client-cert.pem"
}