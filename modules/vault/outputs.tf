output "secret" {
 value = lookup(jsondecode(vault_generic_secret.example.data_json), "password", "")
}
