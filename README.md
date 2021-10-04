[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>][homepage]

[![Terraform Version][badge-terraform]][releases-terraform]
[![Google Provider Version][badge-tf-gcp]][releases-google-provider]
[![Join Slack][badge-slack]][slack]

# terraform-google-memorystore-redis

A [Terraform] module for [Google Cloud Platform (GCP)][gcp].

**_This module supports Terraform version 1
and is compatible with the Terraform Google Provider version 3._**

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.

- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Top-level Arguments](#top-level-arguments)
    - [Module Configuration](#module-configuration)
    - [Main Resource Configuration](#main-resource-configuration)
    - [Extended Resource Configuration](#extended-resource-configuration)
- [Module Attributes Reference](#module-attributes-reference)
- [External Documentation](#external-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

  The name of the resource.
  Default is `true`.ning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

In contrast to the plain `terraform_google_redis_instance` resource this module has better features.
While all security features can be disabled as needed best practices
are pre-configured.

<!--
These are some of our custom features:

- **Default Security Settings**:
  secure by default by setting security to `true`, additional security can be added by setting some feature to `enabled`

- **Standard Module Features**:
  Cool Feature of the main resource, tags

- **Extended Module Features**:
  Awesome Extended Feature of an additional related resource,
  and another Cool Feature

- **Additional Features**:
  a Cool Feature that is not actually a resource but a cool set up from us

- _Features not yet implemented_:
  Standard Features missing,
  Extended Features planned,
  Additional Features planned
-->

## Getting Started

Most basic usage just setting required arguments:

```hcl
module "terraform-google-memorystore-redis" {
    source = "github.com/mineiros-io/terraform-google-memorystore-redis.git?ref=v0.1.0"
}
```

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Top-level Arguments

#### Module Configuration

- **`module_enabled`**: _(Optional `bool`)_

  Specifies whether resources in the module will be created.
  Default is `true`.

- **`module_depends_on`**: _(Optional `list(dependencies)`)_

  A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.

  Example:
  ```hcl
  module_depends_on = [
    google_network.network
  ]
  ```

#### Main Resource Configuration

- **`project`**: **_(Required `string`)_**

  The ID of the project in which the resources belong.

- **`name`**: **_(Required `string`)_**

  The ID of the instance or a fully qualified identifier for the instance.

- **`redis_version`**: **_(Required `string`)_**

  The version of Redis software. For a list of available versions, please find https://cloud.google.com/memorystore/docs/redis/supported-versions

- **`region`**: _(Optional `string`)_

  The region to host the Redis instance in.
  Default is `null`.

- **`authorized_network`**: _(Optional `string`)_

  The full name of the Google Compute Engine network to which the instance is connected. If left unspecified, the default network will be used.
  Default is `null`.

- **`tier`**: _(Optional `string`)_

  The service tier of the instance. Options are `'BASIC'` and `'STANDARD_HA'`. For details please find https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances .
  Default is `STANDARD_HA`.


- **`location_id`**: _(Optional `string`)_

  The zone where the instance will be provisioned. If not provided, the service will choose a zone for the instance. For `'STANDARD_HA'` tier, instances will be created across two zones for protection against zonal failures. If `'alternative_location_id'` is also provided, it must be different from `'location_id'`.
  Default is `null`.

- **`alternative_location_id`**: _(Optional `string`)_

  The alternative zone where the instance will be provisioned.
  Default is `null`.

- **`redis_configs`**: _(Optional `map(string)`)_

  The Redis configuration parameters. For details please find https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#Instance.FIELDS.redis_configs
  Default is `{}`.

- **`transit_encryption_mode`**: _(Optional `string`)_

  The TLS mode of the Redis instance, If not provided, TLS is disabled for the instance. Possible values are `'SERVER_AUTHENTICATION'` for Client to Server traffic encryption and `'DISABLED`'.
  Default is `DISABLED`.

- **`display_name`**: _(Optional `string`)_

  An arbitrary and optional user-provided name for the instance.
  Default is `null`.

- **`reserved_ip_range`**: _(Optional `string`)_

  The CIDR range of internal addresses that are reserved for this instance.
  Default is `null`.

- **`connect_mode`**: _(Optional `string`)_

  The connection mode of the Redis instance. Can be either `DIRECT_PEERING` or `PRIVATE_SERVICE_ACCESS`.
  Default is `DIRECT_PEERING`.

- **`labels`**: _(Optional `map(string)`)_

  The resource labels to represent user provided metadata.
  Default is `{}`.

- **`auth_enabled`**: _(Optional `bool`)_

  Indicates whether OSS Redis AUTH is enabled for the instance. If set to `true` AUTH is enabled on the instance.
  Default is `true`.

- **`memory_size_gb`**: _(Optional `number`)_

  Redis memory size in GiB.
  Default is `1` GiB.

<!-- Example of a required variable:

- **`name`**: **_(Required `string`)_**

  The name of the resource.
  Default is `true`.

-->

<!-- Example of an optional variable:

- **`name`**: _(Optional `string`)_

  The name of the resource.
  Default is `true`.

-->

<!-- Example of an object:
     - We use inline documentation to describe complex objects or lists/maps of complex objects.
     - Please indent each level with 2 spaces so the documentation is rendered in a readable way.

- **`user`**: _(Optional `object(user)`)_

  A user object.
  Default is `true`.

  A/Each `user` object can have the following fields:

  - **`name`**: **_(Required `string`)_**

    The Name of the user.

  - **`description`**: _(Optional `decription`)_

    A description describing the user in more detail.
    Default is "".

  Example
  ```hcl
  user = {
    name        = "marius"
    description = "The guy from Berlin."
  }
  ```
-->

#### Extended Resource Configuration

## Module Attributes Reference

The following attributes are exported in the outputs of the module:

- **`module_enabled`**

  Whether this module is enabled.

- **`redis_instance`**

  A Google Cloud Redis instance.


## External Documentation

- Google Documentation:
  - Memory store redis: https://cloud.google.com/memorystore/docs/redis

- Terraform Google Provider Documentation:
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

Copyright &copy; 2020-2021 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-google-memorystore-redis
[hello@mineiros.io]: mailto:hello@mineiros.io

<!-- markdown-link-check-disable -->

[badge-build]: https://github.com/mineiros-io/terraform-google-memorystore-redis/workflows/Tests/badge.svg

<!-- markdown-link-check-enable -->

[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-google-memorystore-redis.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack

<!-- markdown-link-check-disable -->

[build-status]: https://github.com/mineiros-io/terraform-google-memorystore-redis/actions
[releases-github]: https://github.com/mineiros-io/terraform-google-memorystore-redis/releases

<!-- markdown-link-check-enable -->

[releases-terraform]: https://github.com/hashicorp/terraform/releases
[badge-tf-gcp]: https://img.shields.io/badge/google-3.x-1A73E8.svg?logo=terraform
[releases-google-provider]: https://github.com/terraform-providers/terraform-provider-google/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://mineiros.io/slack
[terraform]: https://www.terraform.io
[gcp]: https://cloud.google.com/
[semantic versioning (semver)]: https://semver.org/

<!-- markdown-link-check-disable -->

[variables.tf]: https://github.com/mineiros-io/terraform-google-memorystore-redis/blob/main/variables.tf
<!-- [examples/]: https://github.com/mineiros-io/terraform-google-memorystore-redis/blob/main/examples -->
[issues]: https://github.com/mineiros-io/terraform-google-memorystore-redis/issues
[license]: https://github.com/mineiros-io/terraform-google-memorystore-redis/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-google-memorystore-redis/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-google-memorystore-redis/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-google-memorystore-redis/blob/main/CONTRIBUTING.md

<!-- markdown-link-check-enable -->
