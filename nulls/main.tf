# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.1.1"
    }

    bombnull = {
        source = "nfagerlund/bombnull"
        version = "~> 4.3.0"
    }
  }
}

variable "pet" {
  type = string
}

variable "inplace_update" {
  type = string
  default = "hey"
}

variable "instances" {
  type = number
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

resource "null_resource" "this" {
  count = var.instances

  triggers = {
    pet = var.pet
  }
}

resource "bombnull_resource" "bomb" {
  triggers = {
    pet = var.pet
  }
  nontriggers = {
    update = var.inplace_update
  }

    bomb_every_time = var.bomb_every_time
    bomb_create = var.bomb_create
    bomb_update = var.bomb_update
    bomb_delete = var.bomb_delete
}

output "ids" {
  value = [for n in null_resource.this: n.id]
}
