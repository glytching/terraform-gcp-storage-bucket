provider "google" {
  # project = var.project_id
  # <snip>
}

module "bucket" {
  source                = "git::https://github.com/glytching/terraform-gcp-storage-bucket.git?ref=v0.1.0"
  cors_origins          = ["*"]
  cors_methods          = ["GET", "POST"]
  cors_response_headers = ["foo", "bar"]
  cors_max_age_seconds  = "3600"
}