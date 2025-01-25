resource "kubernetes_namespace" "keycloak" {
  metadata {
    name = var.namespace
  }
}
resource "helm_release" "keycloak" {
  name       = "keycloak"
  namespace  = kubernetes_namespace.keycloak.id
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "keycloak"
  version    = "24.3.2"
  set {
    name  = "ingress.hostname"
    value = var.hostname
  }
  set {
    name  = "adminIngress.hostname"
    value = var.admin_hostname
  }
  values = [
    file("${path.module}/values-${var.environment}.yaml")
  ]
}