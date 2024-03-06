######
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.15 syntax, which means it is no longer compatible with any versions below 0.12.
######
terraform {
  required_version = ">= 0.15"
  required_providers {
    google = "~> 4.0"
  }

  experiments = [module_variable_optional_attrs]
}

terraform {
  backend "gcs" {
    bucket = "go-agl-sec-shclg-p01-pre-tf-state"
    prefix = "terraform/modules/gcp-cloud-storage/dual-region/state"
  }
  experiments = [module_variable_optional_attrs]
}
