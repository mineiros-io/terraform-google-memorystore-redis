[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-google-memorystore-redis)

[![Build Status](https://github.com/mineiros-io/terraform-google-memorystore-redis/workflows/Tests/badge.svg)](https://github.com/mineiros-io/terraform-google-memorystore-redis/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-google-memorystore-redis.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-google-memorystore-redis/releases)
[![Terraform Version](https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![Google Provider Version](https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-google/releases)
[![Join Slack](https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack)](https://mineiros.io/slack)

# terraform-google-memorystore-redis

A [Terraform](https://www.terraform.io) module to create and manage a
[Google Memorystore Redis Instance](https://cloud.google.com/memorystore/docs/redis/)
on [Google Cloud Services (GCP)](https://cloud.google.com/).

**_This module supports Terraform version 1
and is compatible with the Terraform Google Provider version 4._**

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.


- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Main Resource Configuration](#main-resource-configuration)
  - [Module Configuration](#module-configuration)
- [Module Outputs](#module-outputs)
- [External Documentation](#external-documentation)
  - [Google Documentation](#google-documentation)
  - [Terraform Google Provider Documentation](#terraform-google-provider-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

A [Terraform] base module for creating a `google_redis_instance` resource.

## Getting Started

Most basic usage just setting required arguments:

```hcl
module "terraform-google-memorystore-redis" {
    source = "github.com/mineiros-io/terraform-google-memorystore-redis.git?ref=v0.0.4"

    name           = "private-cache"
    redis_version  = "REDIS_4_0"
}
```

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Main Resource Configuration

- [**`name`**](#var-name): *(**Required** `string`)*<a name="var-name"></a>

  The ID of the instance or a fully qualified identifier for the instance.

- [**`redis_version`**](#var-redis_version): *(**Required** `string`)*<a name="var-redis_version"></a>

  The version of Redis software. For a list of available versions, please find <https://cloud.google.com/memorystore/docs/redis/supported-versions>

- [**`project`**](#var-project): *(Optional `string`)*<a name="var-project"></a>

  The ID of the project in which the resource belongs. If it is not provided, the provider project is used.

- [**`region`**](#var-region): *(Optional `string`)*<a name="var-region"></a>

  The region to host the Redis instance in.

- [**`authorized_network`**](#var-authorized_network): *(Optional `string`)*<a name="var-authorized_network"></a>

  The full name of the Google Compute Engine network to which the instance is connected. If left unspecified, the default network will be used.

- [**`tier`**](#var-tier): *(Optional `string`)*<a name="var-tier"></a>

  The service tier of the instance. Options are `BASIC` and `STANDARD_HA`.

  Default is `"STANDARD_HA"`.

- [**`location_id`**](#var-location_id): *(Optional `string`)*<a name="var-location_id"></a>

  The zone where the instance will be provisioned. If not provided, the service will choose a zone for the instance. For `STANDARD_HA` tier, instances will be created across two zones for protection against zonal failures. If `alternative_location_id` is also provided, it must be different from `location_id`.

- [**`alternative_location_id`**](#var-alternative_location_id): *(Optional `string`)*<a name="var-alternative_location_id"></a>

  The alternative zone where the instance will be provisioned.

  Default is `"null"`.

- [**`redis_configs`**](#var-redis_configs): *(Optional `map(any)`)*<a name="var-redis_configs"></a>

  The Redis configuration parameters. For details please find https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#Instance.FIELDS.redis_configs

  Default is `{}`.

- [**`transit_encryption_mode`**](#var-transit_encryption_mode): *(Optional `string`)*<a name="var-transit_encryption_mode"></a>

  The TLS mode of the Redis instance, If not provided, TLS is disabled for the instance. Possible values are `SERVER_AUTHENTICATION` for Client to Server traffic encryption and `DISABLED`.

  Default is `"DISABLED"`.

- [**`display_name`**](#var-display_name): *(Optional `string`)*<a name="var-display_name"></a>

  An arbitrary and optional user-provided name for the instance.

- [**`reserved_ip_range`**](#var-reserved_ip_range): *(Optional `string`)*<a name="var-reserved_ip_range"></a>

  The CIDR range of internal addresses that are reserved for this instance. If not provided, the service will choose an unused `/29` block, for example, `10.0.0.0/29` or `192.168.0.0/29`. Ranges must be unique and non-overlapping with existing subnets in an authorized network.

- [**`connect_mode`**](#var-connect_mode): *(Optional `string`)*<a name="var-connect_mode"></a>

  The connection mode of the Redis instance. Can be either `DIRECT_PEERING` or `PRIVATE_SERVICE_ACCESS`.

  Default is `"DIRECT_PEERING"`.

- [**`labels`**](#var-labels): *(Optional `map(string)`)*<a name="var-labels"></a>

  The resource labels to represent user provided metadata.

  Default is `{}`.

- [**`auth_enabled`**](#var-auth_enabled): *(Optional `bool`)*<a name="var-auth_enabled"></a>

  Indicates whether OSS Redis AUTH is enabled for the instance. If set to `true` AUTH is enabled on the instance.

  Default is `true`.

- [**`memory_size_gb`**](#var-memory_size_gb): *(Optional `number`)*<a name="var-memory_size_gb"></a>

  Redis memory size in GiB.

  Default is `1`.

- [**`maintenance_policy`**](#var-maintenance_policy): *(Optional `object(maintenance_policy)`)*<a name="var-maintenance_policy"></a>

  Default is `{}`.

  Example:

  ```hcl
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
  ```

  The `maintenance_policy` object accepts the following attributes:

  - [**`description`**](#attr-maintenance_policy-description): *(Optional `string`)*<a name="attr-maintenance_policy-description"></a>

    Description of what this policy is for with a max length of 512 characters.

  - [**`weekly_maintenance_window`**](#attr-maintenance_policy-weekly_maintenance_window): *(Optional `object(weekly_maintenance_window)`)*<a name="attr-maintenance_policy-weekly_maintenance_window"></a>

    Maintenance window that is applied to resources covered by this policy.

    Example:

    ```hcl
    weekly_maintenance_window = {
      day = "FRIDAY"
      start_time = {
        hours   = 6
        minutes = 30
        seconds = 15
        nanos   = 0
      }
    }
    ```

    The `weekly_maintenance_window` object accepts the following attributes:

    - [**`day`**](#attr-maintenance_policy-weekly_maintenance_window-day): *(Optional `string`)*<a name="attr-maintenance_policy-weekly_maintenance_window-day"></a>

      The day of week that maintenance updates occur.

      Default is `"DAY_OF_WEEK_UNSPECIFIED"`.

    - [**`start_time`**](#attr-maintenance_policy-weekly_maintenance_window-start_time): *(Optional `object(start_time)`)*<a name="attr-maintenance_policy-weekly_maintenance_window-start_time"></a>

      Start time of the window in UTC time.

      The `start_time` object accepts the following attributes:

      - [**`hours`**](#attr-maintenance_policy-weekly_maintenance_window-start_time-hours): *(Optional `number`)*<a name="attr-maintenance_policy-weekly_maintenance_window-start_time-hours"></a>

        Hours of day in 24 hour format. Should be from 0 to 23.

      - [**`minutes`**](#attr-maintenance_policy-weekly_maintenance_window-start_time-minutes): *(Optional `number`)*<a name="attr-maintenance_policy-weekly_maintenance_window-start_time-minutes"></a>

        Minutes of hour of day. Must be from 0 to 59.

      - [**`seconds`**](#attr-maintenance_policy-weekly_maintenance_window-start_time-seconds): *(Optional `number`)*<a name="attr-maintenance_policy-weekly_maintenance_window-start_time-seconds"></a>

        Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.

      - [**`nanos`**](#attr-maintenance_policy-weekly_maintenance_window-start_time-nanos): *(Optional `number`)*<a name="attr-maintenance_policy-weekly_maintenance_window-start_time-nanos"></a>

        Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.

### Module Configuration

- [**`module_enabled`**](#var-module_enabled): *(Optional `bool`)*<a name="var-module_enabled"></a>

  Specifies whether resources in the module will be created.

  Default is `true`.

- [**`module_depends_on`**](#var-module_depends_on): *(Optional `list(dependency)`)*<a name="var-module_depends_on"></a>

  A list of dependencies.
  Any object can be _assigned_ to this list to define a hidden external dependency.

  Default is `[]`.

  Example:

  ```hcl
  module_depends_on = [
    google_compute_network.private_redis_network
  ]
  ```

## Module Outputs

The following attributes are exported in the outputs of the module:

- [**`module_enabled`**](#output-module_enabled): *(`bool`)*<a name="output-module_enabled"></a>

  Whether this module is enabled.

- [**`redis_instance`**](#output-redis_instance): *(`object(redis_instance)`)*<a name="output-redis_instance"></a>

  All attributes of the created `google_redis_instance` resource.

## External Documentation

### Google Documentation

- Memory store redis: https://cloud.google.com/memorystore/docs/redis

### Terraform Google Provider Documentation

- https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/redis_instance

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Slack channel][slack].

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-google-memorystore-redis
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-build]: https://github.com/mineiros-io/terraform-google-memorystore-redis/workflows/Tests/badge.svg
[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-google-memorystore-redis.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack
[build-status]: https://github.com/mineiros-io/terraform-google-memorystore-redis/actions
[releases-github]: https://github.com/mineiros-io/terraform-google-memorystore-redis/releases
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[badge-tf-gcp]: https://img.shields.io/badge/google-3.x-1A73E8.svg?logo=terraform
[releases-google-provider]: https://github.com/terraform-providers/terraform-provider-google/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://mineiros.io/slack
[terraform]: https://www.terraform.io
[gcp]: https://cloud.google.com/
[semantic versioning (semver)]: https://semver.org/
[variables.tf]: https://github.com/mineiros-io/terraform-google-memorystore-redis/blob/main/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-google-memorystore-redis/blob/main/examples
[issues]: https://github.com/mineiros-io/terraform-google-memorystore-redis/issues
[license]: https://github.com/mineiros-io/terraform-google-memorystore-redis/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-google-memorystore-redis/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-google-memorystore-redis/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-google-memorystore-redis/blob/main/CONTRIBUTING.md
