module "kubernetes" {
  source      = "./modules/kubernetes"
  environment = "prod"
  pools = [
    {
      type  = "g6-standard-1"
      count = 2
    }
  ]
}
resource "kubernetes_namespace" "example" {
  metadata {
    annotations = {
      name = "example-annotation"
    }

    labels = {
      mylabel = "label-value"
    }

    name = "terraform-example-namespace"
  }
}