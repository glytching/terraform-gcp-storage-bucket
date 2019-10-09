provider "google" {
  # project = var.project_id
  # <snip>
}

module "bucket" {
  source                   = "git::https://github.com/glytching/terraform-gcp-storage-bucket.git?ref=v0.1.0"
  website_main_page_suffix = "index.hmlt"
  website_not_found_page   = "not_found.html"
}
