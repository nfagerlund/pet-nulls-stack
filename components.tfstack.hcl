# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
}

variable "tfcoremock_resource_dir" {
   type = string
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

  tfcoremock = {
    source = "hashicorp/tfcoremock"
    version = "~> 0.2.0"
  }
}

provider "random" "this" {}
provider "null" "this" {}
provider "tfcoremock" "this" {
  config {
    use_only_state = true
    resource_directory = var.tfcoremock_resource_dir
  }
}

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
