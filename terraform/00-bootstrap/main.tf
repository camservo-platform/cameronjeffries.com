resource "linode_object_storage_key" "state" {
  label = "state-file-access"
}

resource "linode_object_storage_bucket" "mybucket" {
  access_key = linode_object_storage_key.state.access_key
  secret_key = linode_object_storage_key.state.secret_key
  region     = var.region
  label      = var.bucket_label
}