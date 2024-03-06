
######
# google_storage_bucket
######

variable "name" {
  description = "Bucket name suffix."
  type        = string
  default     = null
}

variable "cloudbuild_gcs_name" {
  description = "Bucket name without prefix for cloud build."
  type        = string
  default     = null
}

variable "project_id" {
  description = "Bucket project id."
  type        = string
}

variable "offset" {
  description = "The offset to be added to the google cloud storage"
  type        = number
  default     = 1
}

variable "iam" {
  description = "IAM bindings in {ROLE => [MEMBERS]} format."
  type        = map(list(string))
  default     = {}
}

variable "cors" {
  description = "CORS configuration for the bucket. Defaults to null. \n <a name=origin:></a>[origin:](#origin:) The list of Origins eligible to receive CORS response headers. Note: `*` is permitted in the list of origins, and means `any Origin`. \n <a name=method:></a>[method:](#method:) The list of HTTP methods on which to include CORS response headers, (GET, OPTIONS, POST, etc) Note: `*` is permitted in the list of methods, and means `any method`. \n <a name=response_header:></a>[response_header:](#response_header:) The list of HTTP headers other than the simple response headers to give permission for the user-agent to share across domains. \n <a name=max_age_seconds:></a>[max_age_seconds:](#max_age_seconds:) The value, in seconds, to return in the Access-Control-Max-Age header used in preflight responses."
  type = object({
    origin          = list(string)
    method          = list(string)
    response_header = list(string)
    max_age_seconds = number
  })
  default = null
}

variable "encryption_key" {
  description = "KMS key that will be used for encryption."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Optional map to set force destroy keyed by name, defaults to false."
  type        = bool
  default     = false
}

variable "lifecycle_rule" {
  description = "Bucket lifecycle rule. \n <a name=type:></a>[type:](#type:) The type of the action of this Lifecycle Rule. Supported values include: Delete, SetStorageClass and AbortIncompleteMultipartUpload. \n <a name=storage_class:></a>[storage_class:](#storage_class:) The target Storage Class of objects affected by this Lifecycle Rule. Supported values include: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE. \n <a name=age:></a>[age:](#age:) Minimum age of an object in days to satisfy this condition. \n <a name=created_before:></a>[created_before:](#created_before:) A date in the RFC 3339 format YYYY-MM-DD. This condition is satisfied when an object is created before midnight of the specified date in UTC. \n <a name=with_state:></a>[with_state:](#with_state:) Match to live and/or archived objects. Unversioned buckets have only live objects. Supported values include: `LIVE`, `ARCHIVED`, `ANY`. \n <a name=matches_storage_class:></a>[matches_storage_class:](#matches_storage_class:) Storage Class of objects to satisfy this condition. Supported values include: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE, DURABLE_REDUCED_AVAILABILITY. \n <a name=num_newer_versions:></a>[num_newer_versions:](#num_newer_versions:) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition. \n <a name=custom_time_before:></a>[custom_time_before:](#custom_time_before:) A date in the RFC 3339 format YYYY-MM-DD. This condition is satisfied when the customTime metadata for the object is set to an earlier date than the date used in this lifecycle condition. \n <a name=days_since_custom_time:></a>[days_since_custom_time:](#days_since_custom_time:) Days since the date set in the customTime metadata for the object. This condition is satisfied when the current date and time is at least the specified number of days after the customTime. \n <a name=days_since_noncurrent_time:></a>[days_since_noncurrent_time:](#days_since_noncurrent_time:) Relevant only for versioned objects. Number of days elapsed since the noncurrent timestamp of an object. \n <a name=noncurrent_time_before:></a>[noncurrent_time_before:](#noncurrent_time_before:) Relevant only for versioned objects. The date in RFC 3339 (e.g. 2017-06-13) when the object became nonconcurrent."
  type = map(object({
    type                       = string
    storage_class              = optional(string)
    age                        = optional(number)
    created_before             = optional(string)
    with_state                 = optional(string)
    matches_storage_class      = optional(list(string))
    num_newer_versions         = optional(number)
    custom_time_before         = optional(string)
    days_since_custom_time     = optional(string)
    days_since_noncurrent_time = optional(string)
    noncurrent_time_before     = optional(string)
  }))
  default = {
    "default" = {
      type               = "Delete"
      num_newer_versions = 3
    }
  }
}

variable "dual_data_locations" {
  description = "The list of individual regions that comprise a dual-region bucket."
  type        = list(string)
  default     = null
}

variable "autoclass" {
  description = "While set to true, autoclass automatically transitions objects in your bucket to appropriate storage classes based on each object's access pattern."
  type        = bool
  default     = false
}

variable "location" {
  description = "Bucket location."
  type        = string
  default     = "europe-west4"
}

variable "logging_config" {
  description = "Bucket logging configuration. \n <a name=log_bucket:></a>[log_bucket:](#log_bucket:) The bucket that will receive log objects. \n <a name=log_object_prefix:></a>[log_object_prefix:](#log_object_prefix:) The object prefix for log objects. If it's not provided, by default GCS sets this to this bucket's name."
  type = object({
    log_bucket        = string
    log_object_prefix = string
  })
  default = null
}

variable "retention_policy" {
  description = "Bucket retention policy. \n <a name=retention_period:></a>[retention_period:](#retention_period:) The period of time, in seconds, that objects in the bucket must be retained and cannot be deleted, overwritten, or archived. The value must be less than 2,147,483,647 seconds. \n <a name=is_locked:></a>[is_locked:](#is_locked:) If set to true, the bucket will be locked and permanently restrict edits to the bucket's retention policy. Caution: Locking a bucket is an irreversible action."
  type = object({
    retention_period = number
    is_locked        = bool
  })
  default = null
}

variable "storage_class" {
  description = "Bucket storage class."
  type        = string
  default     = "STANDARD"
  validation {
    condition     = contains(["STANDARD", "MULTI_REGIONAL", "REGIONAL", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "Storage class must be one of STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE."
  }
}

variable "uniform_bucket_level_access" {
  description = "Allow using object ACLs (false) or not (true, this is the recommended behavior) , defaults to true (which is the recommended practice, but not the behavior of storage API)."
  type        = bool
  default     = true
}

variable "versioning" {
  description = "Enable versioning."
  type        = bool
  default     = true
}

variable "website" {
  description = "Bucket website. \n <a name=main_page_suffix:></a>[main_page_suffix:](#main_page_suffix:) Behaves as the bucket's directory index where missing objects are treated as potential directories. \n <a name=not_found_page:></a>[not_found_page:](#not_found_page:) The custom object to return when a requested resource is not found."
  type = object({
    main_page_suffix = string
    not_found_page   = string
  })
  default = null
}

variable "folders" {
  description = "Create empties folder in the bucket. Folders name should end with /"
  type        = set(string)
  default     = []
}

######
# Tags
######

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
}
