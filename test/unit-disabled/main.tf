module "test" {
  source = "../.."

  module_enabled = false

  # add all required arguments

  # add only required arguments and no optional arguments
  name          = "unit-disabled"
  redis_version = "none"
}
