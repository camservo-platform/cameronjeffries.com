output "kubernetes" {
  value = linode_lke_cluster.kubernetes
}
output "ca_certificate" {
  value = local.ca_certificate
}