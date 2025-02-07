locals {
  user = "keycloak-admin"
  pass = random_password.password.result
}
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
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
  values = [
    file("${path.module}/values-${var.environment}.yaml")
  ]
  set {
    name  = "auth.adminUser"
    value = local.user
  }
  set {
    name  = "auth.adminPassword"
    value = local.pass
  }
}
