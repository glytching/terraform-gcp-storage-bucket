provider "google" {
  # project = var.project_id
  # <snip>
}

module "bucket" {
  source = "git::https://github.com/glytching/terraform-gcp-storage-bucket.git?ref=v0.1.0"
  name   = "a-caller-supplied-name"
}