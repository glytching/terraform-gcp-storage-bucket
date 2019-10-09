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

output "number_of_buckets" {
  value = "1"
}

output "has_cors" {
  value = "true"
}

output "max_age_seconds" {
  value = var.max_age_seconds
}

output "origins" {
  value = var.origins
}

output "response_headers" {
  value = var.response_headers
}

output "http_methods" {
  value = var.http_methods
}
