output "storage_accounts" {
  value     = module.storage_account
  sensitive = true
}

output "blob" {
  value = module.storage_account.blobs
}
