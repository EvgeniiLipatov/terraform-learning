resource "tls_private_key" "my-test-key" {
  count = var.public_ssh_key_path != "" ? 0 : 1
  algorithm = "RSA"
}