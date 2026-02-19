# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

deployment "simple" {
  inputs = {
    prefix           = "simple"
    instances        = 1
  }
}

deployment "complex" {
  inputs = {
    prefix           = "complexxx"
    instances        = 4
  }
}

publish_output "complex_latepet" {
    description = "The deferred evaluation pet ID from complex deployment"
    value = deployment.complex.global_pet
}

publish_output "simple_latepet" {
    description = "deferred pet id from simple"
    value = deployment.simple.global_pet
}
