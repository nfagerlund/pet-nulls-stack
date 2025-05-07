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
  deployment_group = deployment_group.yolo
}

deployment_group "yolo" {
  auto_approve_checks = [deployment_auto_approve.yolo]
}

deployment_auto_approve "yolo" {
  check {
    condition = true
    reason = "you only live once!!!!"
  }
}
