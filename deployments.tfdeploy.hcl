# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

locals {
  mass_update = "yo"
}

# Twelve simples
deployment "simple_bomb_rowdy1" {
  inputs = {
    prefix           = "simple"
    instances        = 1
    bomb_every_time = true
    bomb_create = false
    bomb_update = false
    bomb_delete = false
  }
  deployment_group = deployment_group.yolo
}

deployment "simple_bomb_rowdy2" {
  inputs = {
    prefix           = "simple2"
    instances        = 1
    bomb_every_time = true
    bomb_create = false
    bomb_update = false
    bomb_delete = false
  }
  deployment_group = deployment_group.normal
}

deployment "simple_bomb_once1" {
  inputs = {
    prefix           = "simple"
    instances        = 1
    bomb_every_time = false
    bomb_create = false
    bomb_update = false
    bomb_delete = false
    inplace_update = local.mass_update
  }
  deployment_group = deployment_group.yolo
}

deployment "simple_bomb_once2" {
  inputs = {
    prefix           = "simple"
    instances        = 1
    bomb_every_time = false
    bomb_create = false
    bomb_update = false
    bomb_delete = false
    inplace_update = local.mass_update
  }
  deployment_group = deployment_group.normal
}

deployment "simple_bomb_once3" {
  inputs = {
    prefix           = "simple"
    instances        = 1
    bomb_every_time = false
    bomb_create = false
    bomb_update = false
    bomb_delete = false
    inplace_update = local.mass_update
  }
  deployment_group = deployment_group.cautious
}

deployment "simple_bomb_once4" {
  inputs = {
    prefix           = "simple"
    instances        = 1
    bomb_every_time = false
    bomb_create = false
    bomb_update = false
    bomb_delete = false
    inplace_update = local.mass_update
  }
  deployment_group = deployment_group.cautious
}

deployment "simple_bomb_once_5" {
  inputs = {
    prefix           = "simple"
    instances        = 1
    bomb_every_time = false
    bomb_create = false
    bomb_update = false
    bomb_delete = false
    inplace_update = local.mass_update
  }
  deployment_group = deployment_group.cautious
}


# No explicit deployment group
deployment "simple13" {
  inputs = {
    prefix           = "simple"
    instances        = 1
    inplace_update = local.mass_update
  }
}

deployment "complex1" {
  inputs = {
    prefix           = "complex"
    instances        = 4
    inplace_update = local.mass_update
  }
  deployment_group = deployment_group.yolo
}

deployment "complex2" {
  inputs = {
    prefix           = "complenx"
    instances        = 4
    inplace_update = local.mass_update
  }
  deployment_group = deployment_group.normal
}

deployment "complex3" {
  inputs = {
    prefix           = "complesx"
    instances        = 4
    inplace_update = local.mass_update
  }
  deployment_group = deployment_group.cautious
}

# Each of these gets four simples and a complex.
deployment_group "yolo" {
    eager_plan = "on"
    failure_tolerance = null
    auto_approve_checks = [ deployment_auto_approve.basic_yolo ]
}

deployment_group "normal" {
    eager_plan = "on"
    failure_tolerance = 3
}

deployment_group "cautious" {
    eager_plan = "off"
    failure_tolerance = 1
}


deployment_auto_approve "basic_yolo" {
    check {
        condition = context.operation == "plan" && context.plan.mode != "destroy" && context.success
        reason = "yoloooooooo"
    }
}

publish_output "complex_latepet" {
    description = "The deferred evaluation pet ID from complex deployment"
    value = deployment.complex1.global_pet
}

publish_output "simple_latepet" {
    description = "deferred pet id from simple"
    value = deployment.simple10.global_pet
}
