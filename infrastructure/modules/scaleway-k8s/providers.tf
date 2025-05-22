terraform {
  required_version = ">= 1.3.0"

  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
    }
    local = {
      source  = "hashicorp/local"
    }
    null = {
      source  = "hashicorp/null"
    }
  }
  }