provider "google" {
  version     = "2.16.0"
  credentials = var.project_editor_key
  project     = var.project_id
}

module "bucket" {
  source                            = "../../../"
  location                          = var.location
  storage_class                     = var.storage_class
  retention_policy_retention_period = var.retention_period
  retention_policy_is_locked        = var.is_locked
}
