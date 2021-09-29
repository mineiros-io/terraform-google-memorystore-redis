resource "google_redis_instance" "redis" {
  count = var.module_enabled ? 1 : 0

  provider = google-beta

  project        = var.project
  name           = var.name
  tier           = var.tier
  memory_size_gb = var.memory_size_gb
  connect_mode   = var.connect_mode

  region                  = var.region
  location_id             = var.location_id
  alternative_location_id = var.alternative_location_id

  authorized_network = var.authorized_network

  redis_version           = var.redis_version
  redis_configs           = var.redis_configs
  auth_enabled            = var.auth_enabled
  transit_encryption_mode = var.transit_encryption_mode
  display_name            = var.display_name
  reserved_ip_range       = var.reserved_ip_range

  labels = var.labels

  depends_on = [var.module_depends_on]
}
