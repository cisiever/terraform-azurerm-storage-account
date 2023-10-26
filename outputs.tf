output "storage_account" {
  description = "Storage Account outputs"
  value       = { for k, v in module.storage_account : k => v.storage_account }
}

output "blobs" {
  description = "Storage Account outputs"
  value       = { for k, v in module.blob : k => v.blob }
}
