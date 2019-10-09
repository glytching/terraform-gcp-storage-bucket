provider "google" {
  version     = "2.16.0"
  credentials = var.project_editor_key
  project     = var.project_id
}

locals {
  bucket_name = format("%s-%s", var.project_id, "test-access-logging")
}

module "bucket_access_logs" {
  source        = "../../../"
  name          = format("%s-%s", local.bucket_name, "access-logs")
  location      = var.location
  storage_class = var.storage_class
}

module "bucket" {
  source            = "../../../"
  name              = local.bucket_name
  log_bucket        = module.bucket_access_logs.name
  log_object_prefix = var.logging_object_prefix
  location          = var.location
  storage_class     = var.storage_class
}