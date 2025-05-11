variable "name" {}
variable "region" {}
variable "zone" {}
variable "node_type" { default = "DEV1-M" }
variable "node_count" { default = 1 }
variable "k8s_version" { default = "1.29.1" }

# ArgoCD & app
variable "app_namespace" { default = "kwatt-dev" }
variable "argocd_enabled" { default = true }
variable "app_repo_url" {}
variable "app_path" {}
variable "app_revision" { default = "master" }

# GHCR secret
variable "ghcr_username" {}
variable "ghcr_pat" {}
variable "ghcr_email" {}
variable "scaleway_private_network_id" {}
