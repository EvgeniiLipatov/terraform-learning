terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.80"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "y0_AgAAAABkJDNtAATuwQAAAADaOPw7chGr8WL_QjO45Tk7OhTyzt-JSNA"
  cloud_id  = "b1g8n29jhnfcbidc4rns"
  folder_id = "b1gmd1d87b5onaoue64r"
}
