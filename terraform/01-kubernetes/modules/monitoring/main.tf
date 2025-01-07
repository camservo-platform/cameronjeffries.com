resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}
resource "helm_release" "monitoring" {
  name       = "prometheus-community"
  namespace  = kubernetes_namespace.monitoring.id
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  values = [
    file("${path.module}/values.yaml")
  ]
}
resource "helm_release" "grafana" {
    name = "grafana"
    namespace = kubernetes_namespace.monitoring.id
    repository = "https://grafana.github.io/helm-charts"
    chart = "grafana"
}