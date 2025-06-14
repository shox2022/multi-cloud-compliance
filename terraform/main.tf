terraform {
  required_providers {
    minio = {
      source  = "kreuzwerker/minio"
      version = ">=0.6.1"
    }
  }
}

provider "minio" {
  alias      = "eu"
  endpoint   = var.regions["EU"]
<<<<<<< HEAD
  access_key = "demo"
  secret_key = "demo123"
=======
  access_key = "demoadmin"
  secret_key = "demoadmin123"
>>>>>>> feature/dashboard-backend
  insecure   = true
}

provider "minio" {
  alias      = "us"
  endpoint   = var.regions["US"]
<<<<<<< HEAD
  access_key = "demo"
  secret_key = "demo123"
=======
  access_key = "demoadmin"
  secret_key = "demoadmin123"
>>>>>>> feature/dashboard-backend
  insecure   = true
}

resource "minio_bucket" "data" {
  for_each = var.regions
  provider = minio[each.key == "EU" ? "eu" : "us"]

  bucket = each.key
  tags = {
    jurisdiction = each.key
    owner        = "demo"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}