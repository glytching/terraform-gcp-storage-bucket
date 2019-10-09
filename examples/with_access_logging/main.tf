provider "google" {
  # project = var.project_id
  # <snip>
}

locals {
  bucket_name   = "a-globally-unique-name"
  location      = "europe-west2"
  storage_class = "REGIONAL"
}

# create a bucket for the access logs
module "bucket_access_logs" {
  source        = "git::https://github.com/glytching/terraform-gcp-storage-bucket.git?ref=v0.1.0"
  name          = format("%s-access-logs", local.bucket_name)
  location      = local.location
  storage_class = local.storage_class
}

# create the main bucket and use the other bucket for its access logs
module "bucket" {
  source        = "git::https://github.com/glytching/terraform-gcp-storage-bucket.git?ref=v0.1.0"
  name          = local.bucket_name
  log_bucket    = module.bucket_access_logs.name
  location      = local.location
  storage_class = local.storage_class
}