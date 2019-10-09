provider "google" {
  # project = var.project_id
  # <snip>
}

module "bucket" {
  source                            = "git::https://github.com/glytching/terraform-gcp-storage-bucket.git?ref=v0.1.0"
  retention_policy_retention_period = "3600"
}
