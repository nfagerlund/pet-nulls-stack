# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
}

variable "tfe_token" {
  type = string
  ephemeral = true
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

  tfe = {
    source = "hashicorp/tfe"
    version = "0.58.1"
  }
}

provider "random" "this" {}
provider "null" "this" {}
provider "tfe" "this" {
  config {
    hostname = "tfe-zone-b0c8608c.ngrok.io"
    token = var.tfe_token
  }
}

component "tfe_project" {
  source = "./tfe_project"

  inputs = {
    project_name = component.pet.name
    workspace_count = component.pet.number
  }

  providers = {
    tfe = provider.tfe.this
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

output "global_pet" {
    value = component.pet.latename
    type = string
}
