provider "google" {
  # project = var.project_id
  # <snip>
}

module "bucket" {
  source             = "git::https://github.com/glytching/terraform-gcp-storage-bucket.git?ref=v0.1.0"
  location           = "europe-west2"
  storage_class      = "REGIONAL"
  force_destroy      = true
  bucket_policy_only = true
  versioning_enabled = true
}
