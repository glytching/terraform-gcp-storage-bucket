provider "google" {
  version     = "2.16.0"
  credentials = var.project_editor_key
  project     = var.project_id
}

module "bucket" {
  source                = "../../../"
  location              = var.location
  storage_class         = var.storage_class
  cors_origins          = var.origins
  cors_methods          = var.http_methods
  cors_response_headers = var.response_headers
  cors_max_age_seconds  = var.max_age_seconds
}