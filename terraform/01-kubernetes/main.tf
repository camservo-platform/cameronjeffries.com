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

# resource "github_actions_organization_secret" "keycloak_user" {
#   secret_name     = "KEYCLOAK_ADMIN_USER"
#   visibility      = "private"
#   plaintext_value = module.keycloak.keycloak_user
# }
# resource "github_actions_organization_secret" "keycloak_pass" {
#   secret_name     = "KEYCLOAK_ADMIN_PASS"
#   visibility      = "private"
#   plaintext_value = module.keycloak.keycloak_pass
# }