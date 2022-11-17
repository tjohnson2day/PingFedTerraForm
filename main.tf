terraform {
  required_providers {
    pingfederate = {
      source = "iwarapter/pingfederate"
      version = "~> 0.0.7"
    }
  }
}

provider "vault" {
  # It is strongly recommended to configure this provider through the
  # environment variables:
       address="http://127.0.0.1:8200"
     #  VAULT_ADDR="http://127.0.0.1:8200"
        token="hvs.A7i1c1k6WC7rE0701Lj1LGOH"
  #    - VAULT_CACERT
  #    - VAULT_CAPATH
  #    - etc.
}

module "secrets" {
  source = "./modules/vault"
  clientId  = var.clientID
}


provider "pingfederate" {
  username = "Administrator"
  password = "Password1"
  base_url = "https://localhost:9999"
  context  = "/pf-admin-api/v1"
  bypass_external_validation = "true"
}

module "oauth-clients" {

  source = "./modules/pingfederate"
  depends_on = [module.secrets]
  clientId  = var.clientID
  secret = module.secrets.secret 
  tokenmanagerId = var.tokenmanagerID
}


