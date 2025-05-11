provider "scaleway/scaleway" {
  access_key = var.scaleway_access_key
  secret_key = var.scaleway_secret_key
  project_id = var.scaleway_project_id
  region     = var.scaleway_region
  zone       = var.scaleway_zone
}

module "dev_cluster" {
  source         = "../modules/scaleway-k8s"
  name           = "kwatt-dev"
  region         = var.scaleway_region
  zone           = var.scaleway_zone
  app_namespace  = "kwatt-dev"
  app_repo_url   = "https://github.com/devkezisoft/kwatt-services-api-gitops"
  app_path       = "apps/kwatt-app/overlays/dev"
  ghcr_username  = var.ghcr_username
  ghcr_pat       = var.ghcr_pat
  ghcr_email     = var.ghcr_email
}
