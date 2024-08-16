# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# TODO: change this to point at a localdev varset
store "varset" "stacktest" {
  id = "varset-Jf29vay69UdGQWbH"
  category = "env"
}

store "tfvars" "stuff" {
  path = "./stuff.tfvars"
}

store "varset" "unused" {
  id = "varset-fakefakefakefa"
  category = "terraform"
}

deployment "simple" {
  inputs = {
    prefix           = store.tfvars.stuff.simple_prefix
    tfcoremock_resource_dir = store.tfvars.stuff.simple_resource_dir
    instances        = 1
  }
}

deployment "complex" {
  inputs = {
    prefix           = store.varset.stacktest.complex_prefix
    prefix = "temporary-nonstore-prefix"
    tfcoremock_resource_dir = "default-constant-dir"
    instances        = 3
  }
}
