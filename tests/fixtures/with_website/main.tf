provider "google" {
  version     = "2.16.0"
  credentials = var.project_editor_key
  project     = var.project_id
}

module "bucket" {
  source                   = "../../../"
  location                 = var.location
  storage_class            = var.storage_class
  website_main_page_suffix = var.main_page_suffix
  website_not_found_page   = var.not_found_page
}
