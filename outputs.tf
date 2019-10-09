output "name" {
  description = "The name of the bucket created by this module"
  value       = google_storage_bucket.default.name
}

output "self_link" {
  description = "The self link of the bucket created by this module"
  value       = google_storage_bucket.default.self_link
}

output "url" {
  description = "The base URL of the bucket created by this module, in the form gs://<name>"
  value       = google_storage_bucket.default.url
}
