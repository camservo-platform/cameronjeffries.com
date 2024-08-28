locals {
  namespaces = []
}
resource "linode_lke_cluster" "kubernetes" {
  k8s_version = var.k8s_version
  label       = "kubernetes-${var.environment}"
  region      = var.region
  tags        = var.tags
  dynamic "pool" {
    for_each = var.pools
    content {
      type  = pool.value["type"]
      count = pool.value["count"]
    }
  }
}
module "ns" {
  for_each = toset(local.namespaces)
  source   = "./modules/namespace"
  name     = each.value
}