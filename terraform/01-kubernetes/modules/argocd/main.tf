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
  ## TODO: Voodoo secret implementation.  It works right now, but I don't know why.
  values = [
    file("${path.module}/values.yaml")
  ]
  
}