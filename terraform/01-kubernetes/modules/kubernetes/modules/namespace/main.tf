# locals {
#   cert_manager_prod = merge(
#     yamldecode("${path.module}/files/cert-manager-prod.yaml"),
#     {
#       "metadata" = {
#         namespace = var.name
#       }
#     }
#   )
#   cert_manager_staging = merge(
#     yamldecode("${path.module}/files/cert-manager-staging.yaml"),
#     {
#       "metadata" = {
#         namespace = var.name
#       }
#     }
#   )
# }
resource "kubernetes_namespace" "this" {
  metadata {
    name = var.name
  }
}
