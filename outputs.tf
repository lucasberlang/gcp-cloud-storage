
######
# google_storage_bucket
######

output "bucket" {
  description = "Bucket resource."
  value       = google_storage_bucket.bucket
}

output "self_link" {
  description = "The URI of the created resource."
  value       = google_storage_bucket.bucket.self_link
}

output "id" {
  description = "Bucket ID (same as name)."
  value       = google_storage_bucket.bucket.id
  depends_on = [
    google_storage_bucket.bucket,
    google_storage_bucket_iam_binding.bindings
  ]
}

output "name" {
  description = "Bucket name."
  value       = google_storage_bucket.bucket.name
  depends_on = [
    google_storage_bucket.bucket,
    google_storage_bucket_iam_binding.bindings
  ]
}

output "url" {
  description = "Bucket URL."
  value       = google_storage_bucket.bucket.url
}
