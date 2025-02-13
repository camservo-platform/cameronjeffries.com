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
## Haven't gotten this one working yet.
resource "helm_release" "vault_secrets_operator" {
  name = "helm-secrets-operator"
  namespace = kubernetes_namespace.vault.id
  repository = "hashicorp"
  chart = "vault-secrets-operator"
  values = [
    file("${path.module}/vault-operator-values.yaml")
  ]
}
# helm install vault-secrets-operator hashicorp/vault-secrets-operator -n vault-secrets-operator-system --create-namespace --values vault/vault-operator-values.yaml
resource "kubernetes_service_account" "vault" {
  metadata {
    name = "k8s-service-account"
    namespace = "backstage"
  }
}