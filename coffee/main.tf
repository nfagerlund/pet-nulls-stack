terraform {
  required_providers {
    tls = {
      source = "hashicorp/tls"
      version = "~> 4.4.1"
    }
  }
}

variable "instances" {
    type = number
}

variable "drink_names" {
    type = set(string)
}

resource "tls_private_key" "singleton_literal" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_private_key" "counted" {
    count = var.instances
    algorithm   = "ECDSA"
    ecdsa_curve = "P384"
}

resource "tls_private_key" "foreached" {
    for_each = var.drink_names
    algorithm   = each.key
    ecdsa_curve = "P384"
}
