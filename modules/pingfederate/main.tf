terraform {
  required_providers {
    pingfederate = {
      source = "iwarapter/pingfederate"
      version = "~> 0.0.7"
    }
  }
}

resource "pingfederate_oauth_access_token_manager" "example" {
  instance_id = var.tokenmanagerId
  name        = var.tokenmanagerId
  plugin_descriptor_ref {
    id = "org.sourceid.oauth20.token.plugin.impl.ReferenceBearerAccessTokenManagementPlugin"
  }
  configuration {
    fields {
      name  = "Token Length"
      value = "28"
    }
    fields {
      name  = "Token Lifetime"
      value = "120"
    }
    fields {
      name  = "Lifetime Extension Policy"
      value = "ALL"
    }
    fields {
      name  = "Maximum Token Lifetime"
      value = ""
    }
    fields {
      name  = "Lifetime Extension Threshold Percentage"
      value = "30"
    }
    fields {
      name  = "Mode for Synchronous RPC"
      value = "3"
    }
    fields {
      name  = "RPC Timeout"
      value = "500"
    }
    fields {
      name  = "Expand Scope Groups"
      value = "false"
    }
  }

  attribute_contract {
    extended_attributes = ["sub"]
  }
}


resource "pingfederate_oauth_client" "example" {
  client_id   = var.clientId 
  name        = "example"
  grant_types = ["CLIENT_CREDENTIALS"]

  client_auth {
    secret = var.secret
    type   = "SECRET"
  }

  default_access_token_manager_ref {
    id = "iiq"
  }

  oidc_policy {
    grant_access_session_revocation_api = false
    logout_uris                         = ["https://logout", "https://foo"]
    ping_access_logout_capable          = true
  }
}

