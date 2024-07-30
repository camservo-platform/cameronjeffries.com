module "kubernetes" {
  source      = "./modules/kubernetes"
  environment = "prod"
  pools = [
    {
      type  = "g6-standard-1"
      count = 1
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
resource "helm_release" "ahoy" {
  name       = "ahoy"
  namespace  = kubernetes_namespace.example.id
  repository = "https://helm.github.io/examples"
  chart      = "hello-world"
}