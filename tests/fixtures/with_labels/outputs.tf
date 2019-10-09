output "project_id" {
  value = var.project_id
}

output "bucket_name" {
  value = module.bucket.name
}

output "bucket_location" {
  value = var.location
}

output "bucket_storage_class" {
  value = var.storage_class
}

output "has_labels" {
  value = "true"
}

output "number_of_buckets" {
  value = "1"
}
