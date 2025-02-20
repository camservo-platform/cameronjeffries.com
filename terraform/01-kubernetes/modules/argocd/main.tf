## Keycloak installation pointed out a circular depndency chain that needs to be addressed.
## This should be removed and deployed separately in it's own repository.
locals {
  vault_plugin_cm      = <<EOT
apiVersion: argoproj.io/v1alpha1
kind: ConfigManagementPlugin
metadata:
  name: argocd-vault-plugin
spec:
  allowConcurrency: true
  discover:
    find:
      command:
        - sh
        - "-c"
        - "find . -name '*.yaml' | xargs -I {} grep \"<path\\|avp\\.kubernetes\\.io\" {} | grep ."
  generate:
    command:
      - argocd-vault-plugin
      - generate
      - "."
  lockRepo: false
EOT
  vault_helm_plugin_cm = <<EOT
---
apiVersion: argoproj.io/v1alpha1
kind: ConfigManagementPlugin
metadata:
  name: argocd-vault-plugin-helm
spec:
  allowConcurrency: true
  discover:
    find:
      command:
        - sh
        - "-c"
        - "find . -name 'Chart.yaml' && find . -name 'values.yaml'"
  generate:
    command:
      - sh
      - "-c"
      - |
        helm template $ARGOCD_APP_NAME --include-crds . |
        argocd-vault-plugin generate -
  lockRepo: false
EOT
}

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

resource "kubernetes_config_map" "plugins" {
  metadata {
    name      = "cmp-plugin"
    namespace = kubernetes_namespace.argocd.id
  }

  data = {
    "avp.yaml"      = local.vault_plugin_cm,
    "avp-helm.yaml" = local.vault_helm_plugin_cm
  }
}