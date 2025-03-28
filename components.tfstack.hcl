# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
}

variable "nulls_instances" {
  type = list(string)
}

locals {
  killnulls = ["hey", "go"]
}

required_providers {
  random = {
    source  = "hashicorp/random"
    version = "~> 3.5.1"
  }

  null = {
    source  = "hashicorp/null"
    version = "~> 3.2.2"
  }
}

provider "random" "this" {}
provider "null" "this" {}

component "pet" {
  source = "./pet"

  inputs = {
    prefix = var.prefix
  }

  providers = {
    random = provider.random.this
    null = provider.null.this
  }
}

component "nulls" {
  source = "./nulls"
  for_each = toset(var.nulls_instances)

  inputs = {
    pet       = "${component.pet.name}--${each.key}"
    instances = var.instances
  }

  providers = {
    null = provider.null.this
  }
}

component "nils" {
  source = "./nulls"

  inputs = {
    pet = component.pet.latename
    instances = component.pet.number
  }

  providers = {
    null = provider.null.this
  }
}

component "nails" {
  source = "./nulls"

  inputs = {
    pet       = component.pet.name
    instances = var.instances
  }

  providers = {
    null = provider.null.this
  }
}

output "pet-latename" {
    description = "yeah"
    value = component.pet.latename
    type = string
}

output "everyone" {
    description = "yep"
    value = component.pet.everyone
    sensitive = true
    type = map(string)
}

# Confirm old removal style ain't broken
removed {
  from = component.nulls["ho"]
  source = "./nulls"

  lifecycle {
    destroy = true
  }

  providers = {
    null = provider.null.this
  }
}

# Okay, that worked! Now let's switch the agent to the updated one and try this...
removed {
  from = component.nulls[each.key]
  source = "./nulls"

  for_each = toset(local.killnulls)

  lifecycle {
    destroy = true
  }

  providers = {
    null = provider.null.this
  }
}
