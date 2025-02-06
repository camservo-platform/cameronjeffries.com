terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "2.7.1"
    }
  }
  backend "s3" {
    # endpoint                    = "us-lax-1.linodeobjects.com"
    endpoints = {
      s3 = "us-lax-1.linodeobjects.com"
    }
    skip_requesting_account_id  = true
    skip_credentials_validation = true
    bucket                      = "cameronjeffries.com.states"
    key                         = "infra/state.json"
    region                      = "us-west-1"
    # access_key = var.aws_access_key_id
    # secret_key = var.aws_secret_access_key
    workspace_key_prefix = ""
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