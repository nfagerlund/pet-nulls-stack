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
    prefix           = "complex"
    instances        = 4
  }
}

publish_output "complex_latepet" {
    description = "The deferred evaluation pet ID from complex deployment"
    value = deployment.complex.global_pet
}
