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

output "main_page_suffix" {
  value = var.main_page_suffix
}

output "not_found_page" {
  value = var.not_found_page
}
