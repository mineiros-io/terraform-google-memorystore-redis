# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "(Required) The ID of the instance or a fully qualified identifier for the instance."
  type        = string
}

variable "redis_version" {
  description = "(Required) The version of Redis software. For a list of available versions, please find https://cloud.google.com/memorystore/docs/redis/supported-versions"
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "project" {
  description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
  default     = null
}

variable "region" {
  description = "(Optional) The region to host the Redis instance in."
  type        = string
  default     = null
}

variable "authorized_network" {
  description = "(Optional) The full name of the Google Compute Engine network to which the instance is connected. If left unspecified, the default network will be used."
  type        = string
  default     = null
}

variable "tier" {
  description = "(Optional) The service tier of the instance. Options are 'BASIC' and 'STANDARD_HA'. For details please find https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#Tier Default is 'STANDARD_HA'."
  type        = string
  default     = "STANDARD_HA"

  validation {
    condition     = can(regex("^(STANDARD_HA|BASIC)$", var.tier))
    error_message = "Tier needs to be either 'BASIC' or 'STANDARD_HA'."
  }
}

variable "location_id" {
  description = "(Optional) The zone where the instance will be provisioned. If not provided, the service will choose a zone for the instance. For 'STANDARD_HA' tier, instances will be created across two zones for protection against zonal failures. If 'alternative_location_id' is also provided, it must be different from 'location_id'."
  type        = string
  default     = null
}

variable "alternative_location_id" {
  description = "(Optional) The alternative zone where the instance will be provisioned."
  type        = string
  default     = null
}

variable "redis_configs" {
  description = "(Optional) The Redis configuration parameters. See (https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#Instance.FIELDS.redis_configs) for details."
  type        = map(any)
  default     = {}
}

variable "transit_encryption_mode" {
  type        = string
  description = "(Optional) The TLS mode of the Redis instance, If not provided, TLS is disabled for the instance. Possible values are 'SERVER_AUTHENTICATION' for Client to Server traffic encryption and 'DISABLED'."
  default     = "DISABLED"

  validation {
    condition     = can(regex("^(DISABLED|SERVER_AUTHENTICATION)$", var.transit_encryption_mode))
    error_message = "Transit encryption mode needs to be either 'SERVER_AUTHENTICATION' for Client to Server traffic encryption and 'DISABLED'."
  }
}

variable "display_name" {
  description = "(Optional) An arbitrary and optional user-provided name for the instance."
  type        = string
  default     = null
}

variable "reserved_ip_range" {
  description = "(Optional) The CIDR range of internal addresses that are reserved for this instance."
  type        = string
  default     = null
}

variable "connect_mode" {
  description = "The connection mode of the Redis instance. Can be either DIRECT_PEERING or PRIVATE_SERVICE_ACCESS. Default is 'DIRECT_PEERING'."
  type        = string
  default     = "DIRECT_PEERING"

  validation {
    condition     = can(regex("^(DIRECT_PEERING|PRIVATE_SERVICE_ACCESS)$", var.connect_mode))
    error_message = "Connectio_mode needs to be either 'DIRECT_PEERING' or 'PRIVATE_SERVICE_ACCESS'."
  }
}

variable "labels" {
  description = "(Optional) The resource labels to represent user provided metadata."
  type        = map(string)
  default     = {}
}

variable "auth_enabled" {
  description = "(Optional) Indicates whether OSS Redis AUTH is enabled for the instance. If set to true AUTH is enabled on the instance. Default is 'true'."
  type        = bool
  default     = true
}

variable "memory_size_gb" {
  description = "Redis memory size in GiB. Default is '1' GiB."
  type        = number
  default     = 1
}

variable "maintenance_policy" {
  description = "(Optional) Maintenance policy for the Redis instance. w"
  type        = any
  # type = object({
  #   # (Optional) Description of what this policy is for with a max length of 512 characters.
  #   description = optional(string)
  #   weekly_maintenance_window = optional(object({
  #     # (Optional) The day of week that maintenance updates occur. Defaults to "DAY_OF_WEEK_UNSPECIFIED". Possible values are:
  #     # DAY_OF_WEEK_UNSPECIFIED: The day of the week is unspecified.
  #     # MONDAY: Monday
  #     # TUESDAY: Tuesday
  #     # WEDNESDAY: Wednesday
  #     # THURSDAY: Thursday
  #     # FRIDAY: Friday
  #     # SATURDAY: Saturday
  #     # SUNDAY: Sunday Possible values are DAY_OF_WEEK_UNSPECIFIED, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, and SUNDAY.
  #     day = string
  #     # (Optional) Start time of the window in UTC time.
  #     start_time = object({
  #       # (Optional) Hours of day in 24 hour format. Should be from 0 to 23.
  #       hours = optional(number)
  #       # (Optional) Minutes of hour of day. Must be from 0 to 59.
  #       minutes = optional(number)
  #       # (Optional) Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.
  #       seconds = optional(number)
  #       # (Optional) Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.
  #       nanos = optional(number)
  #     })
  #   }))
  # })
  default = null
}

# ----------------------------------------------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# ----------------------------------------------------------------------------------------------------------------------

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether or not to create resources within the module."
  default     = true
}

# variable "module_timeouts" {
#   description = "(Optional) A map of timeout objects that is keyed by Terraform resource name defining timeouts for `create`, `update` and `delete` Terraform operations."
#   type        = any
#   default     = null
# }

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends on."
  default     = []
}
