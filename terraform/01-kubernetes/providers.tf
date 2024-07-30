terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "2.7.1"
    }
  }
}
//Use the Linode Provider
provider "linode" {
  token = var.linode_api_key
}
resource "local_file" "kubeconfig" {
  content_base64 = module.kubernetes.kubernetes.kubeconfig
  filename       = "${path.module}/kubeconfig"
}
provider "kubernetes" {
  config_path = "${path.module}/kubeconfig"
}
provider "helm" {
  kubernetes {
    config_path = "${path.module}/kubeconfig"
  }
}