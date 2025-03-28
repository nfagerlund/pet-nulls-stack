# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

deployment "simple" {
  inputs = {
    prefix           = "skrimple"
    instances        = 1
    nulls_instances = []
  }
}

deployment "complex" {
  inputs = {
    prefix           = "complekxt"
    instances        = 5
    nulls_instances = ["lets"]
  }
}
