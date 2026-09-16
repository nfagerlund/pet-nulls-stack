# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
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

  helm = {
    source = "hashicorp/helm"
    version = "2.17.0"
  }
}

provider "random" "this" {}
provider "null" "this" {}
provider "helm" "this" {
    config {
        kubernetes {
            config_path = component.pet.name
        }

        registry {
            url      = component.pet.name
            username = "username"
            password = "password"
        }
    }
}
component "coffee" {
    source = "./coffee"
    inputs = {
        instances = component.pet.number
        drink_names = toset([component.pet.name])
    }

    providers = {
        helm = provider.helm.this
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
