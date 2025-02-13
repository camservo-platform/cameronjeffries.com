locals {
  namespaces        = []
  kubeconfig_string = base64decode(linode_lke_cluster.kubernetes.kubeconfig)
  kubeconfig        = yamldecode(local.kubeconfig_string)
  ca_certificate    = base64decode(local.kubeconfig.clusters[0].cluster["certificate-authority-data"])
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