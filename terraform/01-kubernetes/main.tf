module "kubernetes" {
  source      = "./modules/kubernetes"
  environment = "prod"
  pools = [
    {
      type  = "g6-standard-2"
      count = 2
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
  source         = "./modules/keycloak"
  hostname       = "keycloak.fuckamazon.org"
  admin_hostname = "keycloak-admin.fuckamazon.org"
}
module "keycloak_shiraj" {
  source         = "./modules/keycloak"
  hostname       = "keycloak-shiraj.fuckamazon.org"
  admin_hostname = "keycloak-admin-shiraj.fuckamazon.org"
  namespace      = "keycloak-shiraj"
  environment    = "shiraj"
}
module "monitoring" {
  source = "./modules/monitoring"
}