terraform {
  required_version = ">= 1.0"

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}
