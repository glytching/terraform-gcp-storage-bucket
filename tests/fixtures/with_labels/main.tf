provider "google" {
  version     = "2.16.0"
  credentials = var.project_editor_key
  project     = var.project_id
}

module "bucket" {
  source        = "../../../"
  location      = var.location
  storage_class = var.storage_class
  labels = {
    this = "that"
  }
}