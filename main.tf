
######
# Google Cloud Storage Module
######

locals {
  prefix = join("-", tolist(["go", lower(var.tags.region), var.tags.enterprise, var.tags.account, var.tags.system, ""]))
}

resource "google_storage_bucket" "bucket" {
  name = var.cloudbuild_gcs_name != null ? var.cloudbuild_gcs_name : format(
    "${local.prefix}%s-cs%.2d-%s",
    var.name,
    var.offset,
    var.tags.environment
  )
  project                     = var.project_id
  location                    = var.location
  storage_class               = var.storage_class
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_bucket_level_access

  versioning {
    enabled = var.versioning
  }

  dynamic "website" {
    for_each = var.website == null ? [] : [""]

    content {
      main_page_suffix = var.website.main_page_suffix
      not_found_page   = var.website.not_found_page
    }
  }

  dynamic "encryption" {
    for_each = var.encryption_key == null ? [] : [""]

    content {
      default_kms_key_name = var.encryption_key
    }
  }

  dynamic "retention_policy" {
    for_each = var.retention_policy == null ? [] : [""]
    content {
      retention_period = var.retention_policy.retention_period
      is_locked        = var.retention_policy.is_locked
    }
  }

  dynamic "logging" {
    for_each = var.logging_config == null ? [] : [""]
    content {
      log_bucket        = var.logging_config.log_bucket
      log_object_prefix = var.logging_config.log_object_prefix
    }
  }

  dynamic "cors" {
    for_each = var.cors == null ? [] : [""]
    content {
      origin          = var.cors.origin
      method          = var.cors.method
      response_header = var.cors.response_header
      max_age_seconds = max(3600, var.cors.max_age_seconds)
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule
    content {
      action {
        type          = lifecycle_rule.value.type
        storage_class = lifecycle_rule.value.storage_class
      }
      condition {
        age                        = lifecycle_rule.value.age
        created_before             = lifecycle_rule.value.created_before
        with_state                 = lifecycle_rule.value.with_state
        matches_storage_class      = lifecycle_rule.value.matches_storage_class
        num_newer_versions         = lifecycle_rule.value.num_newer_versions
        custom_time_before         = lifecycle_rule.value.custom_time_before
        days_since_custom_time     = lifecycle_rule.value.days_since_custom_time
        days_since_noncurrent_time = lifecycle_rule.value.days_since_noncurrent_time
        noncurrent_time_before     = lifecycle_rule.value.noncurrent_time_before
      }
    }
  }

  dynamic "custom_placement_config" {
    for_each = var.dual_data_locations != null ? [1] : []
    content {
      data_locations = [for s in var.dual_data_locations : upper(s)]
    }
  }

  dynamic "autoclass" {
    for_each = var.autoclass ? [1] : []
    content {
      enabled = var.autoclass
    }
  }

  labels = merge(
    var.tags,
    {
      "resource_name" = var.cloudbuild_gcs_name != null ? var.cloudbuild_gcs_name : format(
        "${local.prefix}%s-cs%.2d-%s",
        var.name,
        var.offset,
        var.tags.environment
      ),
      "resource_type" = "cloud_storage",
      "deployment_date" = formatdate("DD-MM-YYYY", timestamp())
    }
  )

  # labels = var.tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      labels
    ]
  }
}

resource "google_storage_bucket_iam_binding" "bindings" {
  for_each = var.iam
  bucket   = google_storage_bucket.bucket.name
  role     = each.key
  members  = each.value
}

resource "google_storage_bucket_object" "empty_folder" {
  for_each = var.folders

  name    = each.value
  content = " "
  bucket  = google_storage_bucket.bucket.name
}
