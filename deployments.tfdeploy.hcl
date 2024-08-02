# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# TODO: change this to point at a localdev varset
store "varset" "stacktest" {
  id = "varset-Jf29vay69UdGQWbH"
}

deployment "simple" {
  inputs = {
    prefix           = "simple"
    instances        = 1
  }
}

deployment "complex" {
  inputs = {
    prefix           = store.varset.stacktest.complex_prefix
    instances        = 3
  }
}
