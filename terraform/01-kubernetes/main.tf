module "kubernetes" {
  source      = "./modules/kubernetes"
  environment = "prod"
  pools = [
    {
      type  = "g6-standard-2"
      count = 1
    }
  ]
}
module "vault" {
  source = "./modules/vault"
}
module "argocd" {
  source = "./modules/argocd"
}
module "keycloak" {
  source = "./modules/keycloak"
}
# module "keycloak_shiraj" {
#   source      = "./modules/keycloak"
#   namespace   = "keycloak-shiraj"
#   environment = "shiraj"
# }
# module "monitoring" {
#   source = "./modules/monitoring"
# }