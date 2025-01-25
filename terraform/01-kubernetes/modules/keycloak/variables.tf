variable "hostname" {
  type        = string
  description = "Main keycloak hostname."
}
variable "admin_hostname" {
  type        = string
  description = "Keycloak admin instance hostname"
}
variable "environment" {
  type        = string
  description = "Environment"
  default     = "dev"
}
variable "namespace" {
  type    = string
  default = "keycloak"
}