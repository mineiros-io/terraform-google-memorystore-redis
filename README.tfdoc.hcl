header {
  image = "https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg"
  url   = "https://mineiros.io/?ref=terraform-google-memorystore-redis"

  badge "build" {
    image = "https://github.com/mineiros-io/terraform-google-memorystore-redis/workflows/Tests/badge.svg"
    url   = "https://github.com/mineiros-io/terraform-google-memorystore-redis/actions"
    text  = "Build Status"
  }

  badge "semver" {
    image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-google-memorystore-redis.svg?label=latest&sort=semver"
    url   = "https://github.com/mineiros-io/terraform-google-memorystore-redis/releases"
    text  = "GitHub tag (latest SemVer)"
  }

  badge "terraform" {
    image = "https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform"
    url   = "https://github.com/hashicorp/terraform/releases"
    text  = "Terraform Version"
  }

  badge "tf-gcp-provider" {
    image = "https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform"
    url   = "https://github.com/terraform-providers/terraform-provider-google/releases"
    text  = "Google Provider Version"
  }

  badge "slack" {
    image = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
    url   = "https://mineiros.io/slack"
    text  = "Join Slack"
  }
}

section {
  title   = "terraform-google-memorystore-redis"
  toc     = true
  content = <<-END
    A [Terraform](https://www.terraform.io) module to create a [Google Redis Instance](https://cloud.google.com/memorystore/docs/redis/) on [Google Cloud Services (GCP)](https://cloud.google.com/).

    **_This module supports Terraform version 1
    and is compatible with the Terraform Google Provider version 4._**

    This module is part of our Infrastructure as Code (IaC) framework
    that enables our users and customers to easily deploy and manage reusable,
    secure, and production-grade cloud infrastructure.
  END

  section {
    title   = "Module Features"
    content = <<-END
      A [Terraform] base module for creating a `google_redis_instance` resource.
    END
  }

  section {
    title   = "Getting Started"
    content = <<-END
      Most basic usage just setting required arguments:

      ```hcl
      module "terraform-google-memorystore-redis" {
          source = "github.com/mineiros-io/terraform-google-memorystore-redis.git?ref=v0.1.0"

          name           = "private-cache"
          Project        = "example-project"
          redis_version  = "REDIS_4_0"
      }
      ```
    END
  }

  section {
    title   = "Module Argument Reference"
    content = <<-END
      See [variables.tf] and [examples/] for details and use-cases.
    END

    section {
      title = "Top-level Arguments"

      section {
        title = "Module Configuration"

        variable "module_enabled" {
          type        = bool
          default     = true
          description = <<-END
            Specifies whether resources in the module will be created.
          END
        }

        variable "module_depends_on" {
          type           = list(dependency)
          description    = <<-END
            A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.
          END
          readme_example = <<-END
            module_depends_on = [
              google_network.network
            ]
          END
        }
      }

      section {
        title = "Main Resource Configuration"

        variable "project" {
          required    = true
          type        = string
          description = <<-END
            The ID of the project in which the resources belong.
          END
        }

        variable "name" {
          required    = true
          type        = string
          description = <<-END
            The ID of the instance or a fully qualified identifier for the instance.
          END
        }

        variable "redis_version" {
          required    = true
          type        = string
          description = <<-END
            The version of Redis software. For a list of available versions, please find <https://cloud.google.com/memorystore/docs/redis/supported-versions>
          END
        }

        variable "region" {
          type        = string
          description = <<-END
            The region to host the Redis instance in.
          END
        }

        variable "authorized_network" {
          type        = string
          description = <<-END
            The full name of the Google Compute Engine network to which the instance is connected. If left unspecified, the default network will be used.
          END
        }

        variable "tier" {
          type        = string
          default     = "STANDARD_HA"
          description = <<-END
            The service tier of the instance. Options are `BASIC` and `STANDARD_HA`.
          END
        }

        variable "location_id" {
          type        = string
          description = <<-END
            The zone where the instance will be provisioned. If not provided, the service will choose a zone for the instance. For `STANDARD_HA` tier, instances will be created across two zones for protection against zonal failures. If `alternative_location_id` is also provided, it must be different from `location_id`.
          END
        }

        variable "alternative_location_id" {
          type        = string
          default     = "null"
          description = <<-END
            The alternative zone where the instance will be provisioned.
          END
        }

        variable "redis_configs" {
          type        = map(any)
          default     = {}
          description = <<-END
            The Redis configuration parameters. For details please find https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#Instance.FIELDS.redis_configs
          END
        }

        variable "transit_encryption_mode" {
          type        = string
          default     = "DISABLED"
          description = <<-END
            The TLS mode of the Redis instance, If not provided, TLS is disabled for the instance. Possible values are `SERVER_AUTHENTICATION` for Client to Server traffic encryption and `DISABLED`.
          END
        }

        variable "display_name" {
          type        = string
          description = <<-END
            An arbitrary and optional user-provided name for the instance.
          END
        }

        variable "reserved_ip_range" {
          type        = string
          description = <<-END
            The CIDR range of internal addresses that are reserved for this instance. If not provided, the service will choose an unused `/29` block, for example, `10.0.0.0/29` or `192.168.0.0/29`. Ranges must be unique and non-overlapping with existing subnets in an authorized network.
          END
        }

        variable "connect_mode" {
          type        = string
          default     = "DIRECT_PEERING"
          description = <<-END
            The connection mode of the Redis instance. Can be either `DIRECT_PEERING` or `PRIVATE_SERVICE_ACCESS`.
          END
        }

        variable "labels" {
          type        = map(string)
          default     = {}
          description = <<-END
            The resource labels to represent user provided metadata.
          END
        }

        variable "auth_enabled" {
          type        = bool
          default     = true
          description = <<-END
            Indicates whether OSS Redis AUTH is enabled for the instance. If set to `true` AUTH is enabled on the instance.
          END
        }

        variable "memory_size_gb" {
          type        = number
          default     = 1
          description = <<-END
            Redis memory size in GiB.
          END
        }
      }
    }
  }

  section {
    title   = "Module Outputs"
    content = <<-END
      The following attributes are exported in the outputs of the module:

      - **`module_enabled`**

        Whether this module is enabled.

      - **`redis_instance`**

        All attributes of the created `google_redis_instance` resource.
    END
  }

  section {
    title = "External Documentation"

    section {
      title   = "Google Documentation"
      content = <<-END
        - Memory store redis: https://cloud.google.com/memorystore/docs/redis
      END
    }

    section {
      title   = "Terraform Google Provider Documentation"
      content = <<-END
        - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/redis_instance
      END
    }
  }

  section {
    title   = "Module Versioning"
    content = <<-END
      This Module follows the principles of [Semantic Versioning (SemVer)].

      Given a version number `MAJOR.MINOR.PATCH`, we increment the:

      1. `MAJOR` version when we make incompatible changes,
      2. `MINOR` version when we add functionality in a backwards compatible manner, and
      3. `PATCH` version when we make backwards compatible bug fixes.
    END

    section {
      title   = "Backwards compatibility in `0.0.z` and `0.y.z` version"
      content = <<-END
        - Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
        - Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)
      END
    }
  }

  section {
    title   = "About Mineiros"
    content = <<-END
      [Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
      that solves development, automation and security challenges in cloud infrastructure.

      Our vision is to massively reduce time and overhead for teams to manage and
      deploy production-grade and secure cloud infrastructure.

      We offer commercial support for all of our modules and encourage you to reach out
      if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
      [Community Slack channel][slack].
    END
  }

  section {
    title   = "Reporting Issues"
    content = <<-END
      We use GitHub [Issues] to track community reported issues and missing features.
    END
  }

  section {
    title   = "Contributing"
    content = <<-END
      Contributions are always encouraged and welcome! For the process of accepting changes, we use
      [Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].
    END
  }

  section {
    title   = "Makefile Targets"
    content = <<-END
      This repository comes with a handy [Makefile].
      Run `make help` to see details on each available target.
    END
  }

  section {
    title   = "License"
    content = <<-END
      [![license][badge-license]][apache20]

      This module is licensed under the Apache License Version 2.0, January 2004.
      Please see [LICENSE] for full details.

      Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]
    END
  }
}

references {
  ref "homepage" {
    value = "https://mineiros.io/?ref=terraform-google-memorystore-redis"
  }
  ref "hello@mineiros.io" {
    value = "mailto:hello@mineiros.io"
  }
  ref "badge-build" {
    value = "https://github.com/mineiros-io/terraform-google-memorystore-redis/workflows/Tests/badge.svg"
  }
  ref "badge-semver" {
    value = "https://img.shields.io/github/v/tag/mineiros-io/terraform-google-memorystore-redis.svg?label=latest&sort=semver"
  }
  ref "badge-license" {
    value = "https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg"
  }
  ref "badge-terraform" {
    value = "https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform"
  }
  ref "badge-slack" {
    value = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
  }
  ref "build-status" {
    value = "https://github.com/mineiros-io/terraform-google-memorystore-redis/actions"
  }
  ref "releases-github" {
    value = "https://github.com/mineiros-io/terraform-google-memorystore-redis/releases"
  }
  ref "releases-terraform" {
    value = "https://github.com/hashicorp/terraform/releases"
  }
  ref "badge-tf-gcp" {
    value = "https://img.shields.io/badge/google-3.x-1A73E8.svg?logo=terraform"
  }
  ref "releases-google-provider" {
    value = "https://github.com/terraform-providers/terraform-provider-google/releases"
  }
  ref "apache20" {
    value = "https://opensource.org/licenses/Apache-2.0"
  }
  ref "slack" {
    value = "https://mineiros.io/slack"
  }
  ref "terraform" {
    value = "https://www.terraform.io"
  }
  ref "gcp" {
    value = "https://cloud.google.com/"
  }
  ref "semantic versioning (semver)" {
    value = "https://semver.org/"
  }
  ref "variables.tf" {
    value = "https://github.com/mineiros-io/terraform-google-memorystore-redis/blob/main/variables.tf"
  }
  ref "examples/" {
    value = "https://github.com/mineiros-io/terraform-google-memorystore-redis/blob/main/examples"
  }
  ref "issues" {
    value = "https://github.com/mineiros-io/terraform-google-memorystore-redis/issues"
  }
  ref "license" {
    value = "https://github.com/mineiros-io/terraform-google-memorystore-redis/blob/main/LICENSE"
  }
  ref "makefile" {
    value = "https://github.com/mineiros-io/terraform-google-memorystore-redis/blob/main/Makefile"
  }
  ref "pull requests" {
    value = "https://github.com/mineiros-io/terraform-google-memorystore-redis/pulls"
  }
  ref "contribution guidelines" {
    value = "https://github.com/mineiros-io/terraform-google-memorystore-redis/blob/main/CONTRIBUTING.md"
  }
}
