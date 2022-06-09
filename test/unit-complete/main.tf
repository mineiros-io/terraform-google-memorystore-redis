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

  module_depends_on = ["nothing"]
}
