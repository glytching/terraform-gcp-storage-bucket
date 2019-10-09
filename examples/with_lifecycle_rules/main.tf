provider "google" {
  # project = var.project_id
  # <snip>
}

module "bucket" {
  source = "git::https://github.com/glytching/terraform-gcp-storage-bucket.git?ref=v0.1.0"
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
