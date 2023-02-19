terraform {
  required_providers {
    yandex = {
        source = "yandex-cloud/yandex"
        version = "~> 0.80"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
  }
  required_version = ">= 0.13"
}

