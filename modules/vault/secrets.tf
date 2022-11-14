resource "random_password" "password" {
  length           = 16
  special          = true
}

resource "vault_generic_secret" "example" {
  path = "secret/${var.clientId}"

data_json = jsonencode({
    password = random_password.password.result
  })
}
