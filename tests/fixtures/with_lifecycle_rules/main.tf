provider "google" {
  version     = "2.16.0"
  credentials = var.project_editor_key
  project     = var.project_id
}

module "bucket" {
  source        = "../../../"
  location      = var.location
  storage_class = var.storage_class

  lifecycle_rules = [
    {
      action = {
        type = "Delete"
      }
      condition = {
        age        = 10
        with_state = "ANY"
      }
    },
    {
      action = {
        type          = "SetStorageClass"
        storage_class = "COLDLINE"
      }
      condition = {
        age = 5
      }
    },
  ]
}
