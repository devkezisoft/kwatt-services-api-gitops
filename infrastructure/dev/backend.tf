terraform {
  backend "remote" {
    organization = "devkezisoft"

    workspaces {
      name = "kwatt-dev"
    }
  }
}
