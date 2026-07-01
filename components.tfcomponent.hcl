# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
}

variable "inplace_update" {
    type = string
    default = "heyyy"
}

variable "bomb_every_time" {
    type = bool
    default = false
}

variable "bomb_create" {
    type = bool
    default = false
}

variable "bomb_update" {
    type = bool
    default = false
}

variable "bomb_delete" {
    type = bool
    default = false
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

  bombnull = {
    source = "nfagerlund/bombnull"
    version = "~> 4.3.0"
  }
}

provider "random" "this" {}
provider "null" "this" {}
provider "bombnull" "this" {}

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

  inputs = {
    pet       = component.pet.name
    instances = var.instances
  }

  providers = {
    null = provider.null.this
    bombnull = provider.bombnull.this
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
    bombnull = provider.bombnull.this
  }
}

component "bombs" {
  source = "./nulls"

  inputs = {
    pet = component.pet.latename
    instances = component.pet.number
    bomb_every_time = var.bomb_every_time
    bomb_create = var.bomb_create
    bomb_update = var.bomb_update
    bomb_delete = var.bomb_delete
  }

  providers = {
    null = provider.null.this
    bombnull = provider.bombnull.this
  }
}

output "global_pet" {
    value = component.pet.latename
    type = string
}
