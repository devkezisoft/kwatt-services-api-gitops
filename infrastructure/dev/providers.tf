terraform {
  required_version = ">= 1.3.0"

  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.26.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
  }