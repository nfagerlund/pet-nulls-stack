terraform {
  required_providers {
    helm = {
        source = "hashicorp/helm"
        version = "2.17.0"
    }
  }
}

variable "instances" {
    type = number
}

variable "drink_names" {
    type = set(string)
}

resource "helm_release" "singleton_literal" {
  name       = "nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}

resource "helm_release" "counted" {
    count = var.instances
    name       = "nginx-ingress-controller-${count.index}"

    repository = "https://charts.bitnami.com/bitnami"
    chart      = "nginx-ingress-controller"

    set {
        name  = "service.type"
        value = "ClusterIP"
    }
}

resource "helm_release" "foreached" {
    for_each = var.drink_names

    name       = each.key

    repository = "https://charts.bitnami.com/bitnami"
    chart      = "nginx-ingress-controller"

    set {
        name  = "service.type"
        value = "ClusterIP"
    }
}
