# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.3.2"
    }

    null = {
      source = "hashicorp/null"
      version = "3.1.1"
    }
  }
}

variable "prefix" {
  type = string
}

resource "random_pet" "this" {
  prefix = var.prefix
  length = 3
}

resource "random_integer" "numbor" {
    min = 1
    max = 9
}

resource "random_pet" "them" {
  count = random_integer.numbor.result
  prefix = var.prefix
  length = 3
}

resource "random_pet" "that" {
  prefix = random_pet.this.id
  length = 3
}

data "null_data_source" "everyone" {
  inputs = {
    this = random_pet.this.id
    that = random_pet.that.id
    them = join(", ", random_pet.them[*].id)
    the_other_thing = tostring(random_integer.numbor.result)
  }
}

output "name" {
  value = random_pet.this.id
}

output "latename" {
  value = random_pet.that.id
}

output "number" {
  value = random_integer.numbor.result
}

output "everyone" {
  value = data.null_data_source.everyone.outputs
}
