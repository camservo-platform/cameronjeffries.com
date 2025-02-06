variable "linode_api_key" {
  type = string
}
variable "region" {
  description = "The region where your cluster will be located. (required)"
  default     = "us-lax"
}
variable "bucket_label" {
  type = string
}