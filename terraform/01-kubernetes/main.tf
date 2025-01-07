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
module "monitoring" {
  source = "./modules/monitoring"
}