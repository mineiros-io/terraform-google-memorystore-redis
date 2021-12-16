
# ---------------------------------------------------------------------------------------------------------------------
# SET TERRAFORM AND PROVIDER REQUIREMENTS FOR RUNNING THIS MODULE
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.14, < 2.0"

  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 3.60, < 5.0"
    }
  }
}
