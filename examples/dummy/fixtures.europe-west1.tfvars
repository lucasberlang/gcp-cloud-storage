
name = "dummy"

offset = 1

project_id = "xxxxx"

location = "EU"

force_destroy = true

lifecycle_rule = {
  "1" = {
    type = "Delete"
    age  = 1
  }
  "2" = {
    type = "AbortIncompleteMultipartUpload"
    age  = 1
  }
}

iam = {
  "roles/storage.admin" = ["user:xxxxx"]
}

######
# Tags
######

tags = {
  "provider"                = "go",
  "region"                  = "euw1",
  "enterprise"              = "blue",
  "account"                 = "poc",
  "system"                  = "tst"
  "environment"             = "poc",
  "cmdb_name"               = "",
  "security_exposure_level" = "mz",
  "status"                  = "",
  "on_service"              = "yes",
}
