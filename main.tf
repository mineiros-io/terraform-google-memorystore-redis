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

  dynamic "maintenance_policy" {
    for_each = var.maintenance_policy != null ? [var.maintenance_policy] : []

    content {
      description = try(maintenance_policy.value.description, null)

      dynamic "weekly_maintenance_window" {
        for_each = try([maintenance_policy.value.weekly_maintenance_window], [])

        content {
          day = try(weekly_maintenance_window.value.day, "DAY_OF_WEEK_UNSPECIFIED")

          dynamic "start_time" {
            for_each = try([weekly_maintenance_window.value.start_time], [])

            content {
              hours   = try(start_time.value.hours, 0)
              minutes = try(start_time.value.minutes, 30)
              seconds = try(start_time.value.seconds, 0)
              nanos   = try(start_time.value.nanos, 0)
            }
          }
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      maintenance_schedule,
    ]
  }

  depends_on = [var.module_depends_on]
}
