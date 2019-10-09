output "project_id" {
  value = var.project_id
}

output "bucket_name" {
  value = local.bucket_name
}

output "bucket_location" {
  value = var.location
}

output "bucket_storage_class" {
  value = var.storage_class
}

output "number_of_buckets" {
  value = "2"
}

output "logging_bucket_name" {
  value = module.bucket_access_logs.name
}

output "logging_object_prefix" {
  value = var.logging_object_prefix
}