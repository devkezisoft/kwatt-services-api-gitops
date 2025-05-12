terraform {
  backend "s3" {
    bucket  = "kwatt-terraform-state"
    key     = "dev/terraform.tfstate"
    region  = "fr-par"
    endpoint = "https://kwatt-terraform-state.s3.fr-par.scw.cloud"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}