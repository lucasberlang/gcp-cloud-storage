
output "bucket" {
  description = "Bucket resource."
  value       = module.cloud_storage.bucket
}

output "id" {
  description = "Bucket ID (same as name)."
  value       = module.cloud_storage.id
}

output "name" {
  description = "Bucket name."
  value       = module.cloud_storage.name
}

output "url" {
  description = "Bucket URL."
  value       = module.cloud_storage.url
}
