resource "vault_mount" "kv-v2" {
  path = "kv-v2"
  type = "kv-v2"
}

resource "vault_mount" "transit" {
  path = "transit"
  type = "transit"
}

resource "vault_transit_secret_backend_key" "key" {
  depends_on       = [vault_mount.transit]
  backend          = "transit"
  name             = "dummytransit"
  deletion_allowed = true
}