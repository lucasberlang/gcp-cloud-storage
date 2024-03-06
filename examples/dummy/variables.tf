
variable "project_id" {
  description = "fixture"
  type        = string
}

variable "region" {
  description = "fixture"
  type        = string
  default     = "europe-west1"
}

######
# Vars
######

variable "name" {
  description = "Bucket name suffix."
  type        = string
}

variable "offset" {
  description = "The offset to be added to the google cloud storage"
  type        = number
  default     = 1
}

variable "force_destroy" {
  description = "Optional map to set force destroy keyed by name, defaults to false."
  type        = bool
}

variable "iam" {
  description = "IAM bindings in {ROLE => [MEMBERS]} format."
  type        = map(list(string))
  default     = {}
}

variable "lifecycle_rule" {
  description = "Bucket lifecycle rule. \n <a name=type:></a>[type:](#type:) The type of the action of this Lifecycle Rule. Supported values include: Delete, SetStorageClass and AbortIncompleteMultipartUpload. \n <a name=storage_class:></a>[storage_class:](#storage_class:) The target Storage Class of objects affected by this Lifecycle Rule. Supported values include: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE. \n <a name=age:></a>[age:](#age:) Minimum age of an object in days to satisfy this condition. \n <a name=created_before:></a>[created_before:](#created_before:) A date in the RFC 3339 format YYYY-MM-DD. This condition is satisfied when an object is created before midnight of the specified date in UTC. \n <a name=with_state:></a>[with_state:](#with_state:) Match to live and/or archived objects. Unversioned buckets have only live objects. Supported values include: `LIVE`, `ARCHIVED`, `ANY`. \n <a name=matches_storage_class:></a>[matches_storage_class:](#matches_storage_class:) Storage Class of objects to satisfy this condition. Supported values include: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE, DURABLE_REDUCED_AVAILABILITY. \n <a name=num_newer_versions:></a>[num_newer_versions:](#num_newer_versions:) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition. \n <a name=custom_time_before:></a>[custom_time_before:](#custom_time_before:) A date in the RFC 3339 format YYYY-MM-DD. This condition is satisfied when the customTime metadata for the object is set to an earlier date than the date used in this lifecycle condition. \n <a name=days_since_custom_time:></a>[days_since_custom_time:](#days_since_custom_time:) Days since the date set in the customTime metadata for the object. This condition is satisfied when the current date and time is at least the specified number of days after the customTime. \n <a name=days_since_noncurrent_time:></a>[days_since_noncurrent_time:](#days_since_noncurrent_time:) Relevant only for versioned objects. Number of days elapsed since the noncurrent timestamp of an object. \n <a name=noncurrent_time_before:></a>[noncurrent_time_before:](#noncurrent_time_before:) Relevant only for versioned objects. The date in RFC 3339 (e.g. 2017-06-13) when the object became nonconcurrent."
  type = map(object({
    type                       = string
    storage_class              = optional(string)
    age                        = number
    created_before             = optional(string)
    with_state                 = optional(string)
    matches_storage_class      = optional(list(string))
    num_newer_versions         = optional(string)
    custom_time_before         = optional(string)
    days_since_custom_time     = optional(string)
    days_since_noncurrent_time = optional(string)
    noncurrent_time_before     = optional(string)
  }))
  default = null
}

######
# Tags
######

variable "tags" {
  description = "fixture"
  type        = map(string)
}
