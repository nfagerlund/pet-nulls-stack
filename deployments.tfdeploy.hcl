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
    prefix           = upstream_input.elsewhere.complex_latepet
    instances        = 4
  }
}

upstream_input "elsewhere" {
    type = "stack"
    source = "app.terraform.io/gacorp/stack-heck/sep25-output-publisher-1"
}
