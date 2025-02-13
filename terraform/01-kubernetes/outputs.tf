# output "kubernetes" {
#   value = module.kubernetes
# }
output "kubernetes_ca_certificate" {
  value     = module.kubernetes.ca_certificate
  sensitive = true
}