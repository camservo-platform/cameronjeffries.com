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
    file("${path.module}/values.yaml")
  ]
  set_sensitive {
    name = "server.config.oidc.config"
    value = <<EOT
      name: Keycloak
      issuer: http://keycloak.fuckamazon.org/auth/realms/camservo
      clientID: argocd
      clientSecret: ${var.keycloak_secret}
      requestedScopes: ['openid', 'profile', 'email', 'groups']
    EOT
  }
}