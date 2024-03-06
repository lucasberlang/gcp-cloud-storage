
name = "dummy"

offset = 1

project_id = "agl-sec-segcld-pre-00"

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
  "roles/storage.admin" = ["user:lucas.calvo@bluetab.com"]
}

######
# Tags
######

tags = {
  "provider"                = "go",
  "region"                  = "euw1",
  "enterprise"              = "cxb",
  "account"                 = "poc",
  "system"                  = "tst"
  "environment"             = "poc",
  "cmdb_name"               = "",
  "security_exposure_level" = "mz",
  "status"                  = "",
  "on_service"              = "yes",
}
