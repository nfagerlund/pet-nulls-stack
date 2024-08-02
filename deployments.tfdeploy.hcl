# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# TODO: change this to point at a localdev varset
store "varset" "stacktest" {
  id = "varset-Jf29vay69UdGQWbH"
}

store "tfvars" "stuff" {
  path = "./stuff.tfvars"
}

store "varset" "unused" {
  id = "varset-fakefakefakefa"
}

deployment "simple" {
  inputs = {
    prefix           = store.tfvars.stuff.simple_prefix
    instances        = 1
  }
}

deployment "complex" {
  inputs = {
    prefix           = store.varset.stacktest.complex_prefix
    instances        = 3
  }
}
