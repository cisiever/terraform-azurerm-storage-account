module "storage_account" {
  source = "../../"

  blobs = {
    blob1 = {
      storage_account_name  = "pdsaexample"
      create_container      = false
      container_name        = "tfs"
      container_access_type = "private"
      blob_name             = "main.tf"
      type                  = "Block"
      blob_source           = "${path.cwd}/main.tf"
    }
  }
}
