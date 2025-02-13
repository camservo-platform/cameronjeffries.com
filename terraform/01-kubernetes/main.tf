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
  source          = "./modules/argocd"
  keycloak_secret = var.keycloak_secret
}
module "keycloak" {
  source = "./modules/keycloak"
}