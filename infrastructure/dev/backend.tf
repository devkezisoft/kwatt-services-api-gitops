terraform {
  backend "s3" {
    bucket  = "kwatt-terraform-state"
    key     = "dev/terraform.tfstate"
    region  = "eu-west-3"

    endpoint                    = "https://s3.fr-par.scw.cloud"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}