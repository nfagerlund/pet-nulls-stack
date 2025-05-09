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
    prefix           = "compleux"
    instances        = 4
  }
}
