provider "google" {
  version     = "2.16.0"
  credentials = var.project_editor_key
  project     = var.project_id
}

locals {
  bucket_name = format("%s-%s", var.project_id, "test-caller-supplied-name")
}

module "bucket" {
  source        = "../../../"
  name          = local.bucket_name
  location      = var.location
  storage_class = var.storage_class
}