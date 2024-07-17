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