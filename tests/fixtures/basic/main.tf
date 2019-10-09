provider "google" {
  version     = "2.16.0"
  credentials = var.project_editor_key
  project     = var.project_id
}

module "bucket" {
  source             = "../../../"
  location           = var.location
  storage_class      = var.storage_class
  versioning_enabled = var.versioning
  force_destroy      = true
  bucket_policy_only = true
}
