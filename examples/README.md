Each of the examples in this directory focuses on a discrete feature. The intention is to present the attributes which relate to each feature on their own so as to make each of them easier to understand.

However, the bucket features are not mutually exclusive so you can, of course, mix and match. For example:

```hcl-terraform
provider "google" {
  # project = var.project_id
  # <snip>
}

module "bucket" {
  source             = "git::https://github.com/glytching/terraform-gcp-storage-bucket.git?ref=v0.1.0"
  name               = "a-globally-unique-name"
  location           = "europe-west2"
  storage_class      = "REGIONAL"
  force_destroy      = true
  bucket_policy_only = true
  versioning_enabled = true

  # retain for 30 days
  retention_policy_retention_period = "2592000"
 
  # add some labels
  labels = {
    owner       = "bob"
    environment = "dev"
  }

  # move to cold storage after 15 days
  lifecycle_rules = [
    {
      action = {
        type          = "SetStorageClass"
        storage_class = "COLDLINE"
      }
      condition = {
        age = 15
      }
    },
  ]
}
```