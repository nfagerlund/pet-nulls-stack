# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

deployment "simple" {
  inputs = {
    prefix           = "simplee"
    instances        = 1
  }
}

deployment "complex" {
  inputs = {
    prefix           = upstream_input.elsewhere.complex_latepet
    instances        = 3
  }
}

upstream_input "elsewhere" {
    type = "stack"
    source = "app.terraform.io/gacorp/stack-heck/jan26-upstream"
}

publish_output "complex_latepet" {
    description = "The deferred evaluation pet ID from complex deployment"
    value = deployment.complex.global_pet
}

publish_output "simple_latepet" {
    description = "deferred pet id from simple"
    value = deployment.simple.global_pet
}
