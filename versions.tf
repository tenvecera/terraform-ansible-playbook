terraform {
  required_version = ">= 1.4"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}
