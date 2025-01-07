resource "kubernetes_namespace" "keycloak" {
  metadata {
    name = "keycloak"
  }
}
resource "helm_release" "keycloak" {
  name       = "keycloak"
  namespace  = kubernetes_namespace.keycloak.id
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "keycloak"
  values = [
    file("${path.module}/values.yaml")
  ]
}