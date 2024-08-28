resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
  }
}
resource "helm_release" "vault" {
  name       = "vault"
  namespace  = kubernetes_namespace.vault.id
  repository = "https://helm.releases.hashicorp.com/"
  chart      = "vault"
  values = [
    file("${path.module}/values.yaml")
  ]
}