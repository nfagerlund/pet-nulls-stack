# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.3.2"
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

output "name" {
  value = random_pet.this.id
}

output "latename" {
  value = random_pet.that.id
}

output "number" {
  value = random_integer.numbor.result
}

