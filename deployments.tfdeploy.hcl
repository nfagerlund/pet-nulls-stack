# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

store "varset" "stack_dump" {
  id = "varset-XmNVfWCAh4SXvC9R"
  category = "env"
}

deployment "simple" {
  inputs = {
    prefix           = "simple"
    instances        = 1
    tfe_token = store.varset.stack_dump.TFE_TOKEN
  }
}

deployment "complex" {
  inputs = {
    prefix           = "complex"
    instances        = 3
    tfe_token = store.varset.stack_dump.TFE_TOKEN
  }
}
