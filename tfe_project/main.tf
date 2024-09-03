terraform {
  required_providers {
    tfe = {
      source = "hashicorp/tfe"
      version = "0.58.1"
    }
  }
}

variable "project_name" {
  type = string
}

variable "workspace_count" {
  type = number
}

locals {
  org = "testbed"
}

resource "tfe_project" "this" {
  organization = local.org
  name = var.project_name
}

resource "tfe_workspace" "these" {
  count = var.workspace_count

  name = "some_workspace${count.index}"
  organization = local.org
  project_id = tfe_project.this.id
  auto_apply = true
}
