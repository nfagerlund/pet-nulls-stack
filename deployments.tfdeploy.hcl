# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

deployment "simple" {
  variables = {
    prefix           = "simple"
    instances        = 1
  }
}

deployment "complex" {
  variables = {
    prefix           = "complex"
    instances        = 3
  }
}
