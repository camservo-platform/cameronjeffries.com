resource "vault_policy" "policy1" {
  name   = "policytf1"
  policy = file("${path.module}/policy/policy1.hcl")
}
resource "vault_policy" "policy2" {
  name   = "policytf2"
  policy = file("${path.module}/policy/policy2.hcl")
}