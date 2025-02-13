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

# Create a new token and add to VAULT_RO_TOKEN after creating vault.
# This will be used to retrieve the secrets for the configuration terraform repository.
# The token will need root access.
module "vault" {
  source = "./modules/vault"
}

# Adding in argocd.  Consider moving this to it's own repo?
module "argocd" {
  source          = "./modules/argocd"
  keycloak_secret = var.keycloak_secret
}

# Adding in keycloak.  Also consider moving to it's own repo.
module "keycloak" {
  source = "./modules/keycloak"
}