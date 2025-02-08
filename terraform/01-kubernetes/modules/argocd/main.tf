## Keycloak installation pointed out a circular depndency chain that needs to be addressed.
## This should be removed and deployed separately in it's own repository.

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}
resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = kubernetes_namespace.argocd.id
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  values = [
    templatefile(
      "${path.module}/templates/values.yaml.tpl",
      {
        "keycloak_secret" = var.keycloak_secret
      }
    )
  ]
  
}