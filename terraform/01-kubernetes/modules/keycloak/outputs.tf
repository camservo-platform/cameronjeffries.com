output "keycloak_user" {
  value = local.user
  sensitive = false
}
output "keycloak_pass" {
  value = local.pass
  sensitive = true
}