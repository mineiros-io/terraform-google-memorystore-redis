# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# COMPLETE FEATURES UNIT TEST
# This module tests a complete set of most/all non-exclusive features
# The purpose is to activate everything the module offers, but trying to keep execution time and costs minimal.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

variable "gcp_region" {
  type        = string
  description = "(Required) The gcp region in which all resources will be created."
}

variable "gcp_project" {
  type        = string
  description = "(Required) The ID of the project in which the resource belongs."
}

terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.0"
    }
  }
}

provider "google-beta" {
  region  = var.gcp_region
  project = var.gcp_project
}

# DO NOT RENAME MODULE NAME
module "test" {
  source = "../.."

  module_enabled = true

  # add all required arguments
  name          = "unit-complete"
  redis_version = "REDIS_6_X"
  # add all optional arguments that create additional resources

  # add most/all other optional arguments
  project        = var.gcp_project
  region         = var.gcp_region
  display_name   = "UnitComplete"
  memory_size_gb = 2
  auth_enabled   = true

  labels = {
    my_key    = "my_val"
    other_key = "other_val"
  }

  tier = "STANDARD_HA"
  # TODO: add comprehensive test that tests private service access
  # connect_mode = "PRIVATE_SERVICE_ACCESS"

  redis_configs = {
    stream-node-max-bytes = "200"
  }

  location_id             = "europe-west3-a"
  alternative_location_id = "europe-west3-b"

  maintenance_policy = {
    description = "Maintainence on Fridays"
    weekly_maintenance_window = {
      day = "FRIDAY"
      start_time = {
        hours   = 6
        minutes = 30
        seconds = 15
        nanos   = 0
      }
    }
  }

  # module_timeouts = {
  #   google_monitoring_notification_channel = {
  #     create = "10m"
  #     update = "10m"
  #     delete = "10m"
  #   }
  # }

  module_depends_on = ["nothing"]
}

# outputs generate non-idempotent terraform plans so we disable them for now unless we need them.
# output "all" {
#   description = "All outputs of the module."
#   value       = module.test
# }
