resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_generic_endpoint" "dummyuser" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/dummyusers"
  ignore_absent_fields = true
  data_json            = <<EOF
{
"policies" : ["admin", "dummy-users"],
"password" : "pleasechangeme"
}
EOF
}

resource "vault_generic_endpoint" "cameron" {
  path      = "auth/userpass/users/cameron"
  data_json = <<EOF
{
"policies" : ["admin", "dummy-users"],
"password" : "pleasechangeme"
}
EOF
}