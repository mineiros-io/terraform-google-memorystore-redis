module "test" {
  source = "../.."

  # add only required arguments and no optional arguments
  name          = "unit-minimal"
  redis_version = "REDIS_4_0"
}
