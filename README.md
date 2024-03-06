# Google Cloud Storage Terraform Module

Terraform module which creates a cloud storage bucket on GCP.

Inspired by and adapted from [this](https://registry.terraform.io/modules/terraform-google-modules/cloud-storage)
and its [source code](https://github.com/terraform-google-modules/terraform-google-cloud-storage).

* [GCP Storage Bucket](https://www.terraform.io/docs/providers/google/r/storage_bucket.html)

## Terraform versions

Supported version 0.15 and higher.

## Usage

```hcl
module "gcp-cloud-storage" {
  source = "git::https://github.com/lucasberlang/gcp-cloud-storage.git?ref=v1.4.0"

  [...]
}
```

>The value of the ref source argument can be any terraform module version, please see [version list](https://github.com/lucasberlang/gcp-cloud-storage/tags). We recommend the use of the most updated version.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.46.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_binding.bindings](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [google_storage_bucket_object.empty_folder](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoclass"></a> [autoclass](#input\_autoclass) | While set to true, autoclass automatically transitions objects in your bucket to appropriate storage classes based on each object's access pattern. | `bool` | `false` | no |
| <a name="input_cloudbuild_gcs_name"></a> [cloudbuild\_gcs\_name](#input\_cloudbuild\_gcs\_name) | Bucket name without prefix for cloud build. | `string` | `null` | no |
| <a name="input_cors"></a> [cors](#input\_cors) | CORS configuration for the bucket. Defaults to null. <br> <a name=origin:></a>[origin:](#origin:) The list of Origins eligible to receive CORS response headers. Note: `*` is permitted in the list of origins, and means `any Origin`. <br> <a name=method:></a>[method:](#method:) The list of HTTP methods on which to include CORS response headers, (GET, OPTIONS, POST, etc) Note: `*` is permitted in the list of methods, and means `any method`. <br> <a name=response\_header:></a>[response\_header:](#response\_header:) The list of HTTP headers other than the simple response headers to give permission for the user-agent to share across domains. <br> <a name=max\_age\_seconds:></a>[max\_age\_seconds:](#max\_age\_seconds:) The value, in seconds, to return in the Access-Control-Max-Age header used in preflight responses. | <pre>object({<br>    origin          = list(string)<br>    method          = list(string)<br>    response_header = list(string)<br>    max_age_seconds = number<br>  })</pre> | `null` | no |
| <a name="input_dual_data_locations"></a> [dual\_data\_locations](#input\_dual\_data\_locations) | The list of individual regions that comprise a dual-region bucket. | `list(string)` | `null` | no |
| <a name="input_encryption_key"></a> [encryption\_key](#input\_encryption\_key) | KMS key that will be used for encryption. | `string` | `null` | no |
| <a name="input_folders"></a> [folders](#input\_folders) | Create empties folder in the bucket. Folders name should end with / | `set(string)` | `[]` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Optional map to set force destroy keyed by name, defaults to false. | `bool` | `false` | no |
| <a name="input_iam"></a> [iam](#input\_iam) | IAM bindings in {ROLE => [MEMBERS]} format. | `map(list(string))` | `{}` | no |
| <a name="input_lifecycle_rule"></a> [lifecycle\_rule](#input\_lifecycle\_rule) | Bucket lifecycle rule. <br> <a name=type:></a>[type:](#type:) The type of the action of this Lifecycle Rule. Supported values include: Delete, SetStorageClass and AbortIncompleteMultipartUpload. <br> <a name=storage\_class:></a>[storage\_class:](#storage\_class:) The target Storage Class of objects affected by this Lifecycle Rule. Supported values include: STANDARD, MULTI\_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE. <br> <a name=age:></a>[age:](#age:) Minimum age of an object in days to satisfy this condition. <br> <a name=created\_before:></a>[created\_before:](#created\_before:) A date in the RFC 3339 format YYYY-MM-DD. This condition is satisfied when an object is created before midnight of the specified date in UTC. <br> <a name=with\_state:></a>[with\_state:](#with\_state:) Match to live and/or archived objects. Unversioned buckets have only live objects. Supported values include: `LIVE`, `ARCHIVED`, `ANY`. <br> <a name=matches\_storage\_class:></a>[matches\_storage\_class:](#matches\_storage\_class:) Storage Class of objects to satisfy this condition. Supported values include: STANDARD, MULTI\_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE, DURABLE\_REDUCED\_AVAILABILITY. <br> <a name=num\_newer\_versions:></a>[num\_newer\_versions:](#num\_newer\_versions:) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition. <br> <a name=custom\_time\_before:></a>[custom\_time\_before:](#custom\_time\_before:) A date in the RFC 3339 format YYYY-MM-DD. This condition is satisfied when the customTime metadata for the object is set to an earlier date than the date used in this lifecycle condition. <br> <a name=days\_since\_custom\_time:></a>[days\_since\_custom\_time:](#days\_since\_custom\_time:) Days since the date set in the customTime metadata for the object. This condition is satisfied when the current date and time is at least the specified number of days after the customTime. <br> <a name=days\_since\_noncurrent\_time:></a>[days\_since\_noncurrent\_time:](#days\_since\_noncurrent\_time:) Relevant only for versioned objects. Number of days elapsed since the noncurrent timestamp of an object. <br> <a name=noncurrent\_time\_before:></a>[noncurrent\_time\_before:](#noncurrent\_time\_before:) Relevant only for versioned objects. The date in RFC 3339 (e.g. 2017-06-13) when the object became nonconcurrent. | <pre>map(object({<br>    type                       = string<br>    storage_class              = optional(string)<br>    age                        = optional(number)<br>    created_before             = optional(string)<br>    with_state                 = optional(string)<br>    matches_storage_class      = optional(list(string))<br>    num_newer_versions         = optional(number)<br>    custom_time_before         = optional(string)<br>    days_since_custom_time     = optional(string)<br>    days_since_noncurrent_time = optional(string)<br>    noncurrent_time_before     = optional(string)<br>  }))</pre> | <pre>{<br>  "default": {<br>    "num_newer_versions": 3,<br>    "type": "Delete"<br>  }<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | Bucket location. | `string` | `"europe-west4"` | no |
| <a name="input_logging_config"></a> [logging\_config](#input\_logging\_config) | Bucket logging configuration. <br> <a name=log\_bucket:></a>[log\_bucket:](#log\_bucket:) The bucket that will receive log objects. <br> <a name=log\_object\_prefix:></a>[log\_object\_prefix:](#log\_object\_prefix:) The object prefix for log objects. If it's not provided, by default GCS sets this to this bucket's name. | <pre>object({<br>    log_bucket        = string<br>    log_object_prefix = string<br>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Bucket name suffix. | `string` | `null` | no |
| <a name="input_offset"></a> [offset](#input\_offset) | The offset to be added to the google cloud storage | `number` | `1` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Bucket project id. | `string` | n/a | yes |
| <a name="input_retention_policy"></a> [retention\_policy](#input\_retention\_policy) | Bucket retention policy. <br> <a name=retention\_period:></a>[retention\_period:](#retention\_period:) The period of time, in seconds, that objects in the bucket must be retained and cannot be deleted, overwritten, or archived. The value must be less than 2,147,483,647 seconds. <br> <a name=is\_locked:></a>[is\_locked:](#is\_locked:) If set to true, the bucket will be locked and permanently restrict edits to the bucket's retention policy. Caution: Locking a bucket is an irreversible action. | <pre>object({<br>    retention_period = number<br>    is_locked        = bool<br>  })</pre> | `null` | no |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | Bucket storage class. | `string` | `"STANDARD"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | n/a | yes |
| <a name="input_uniform_bucket_level_access"></a> [uniform\_bucket\_level\_access](#input\_uniform\_bucket\_level\_access) | Allow using object ACLs (false) or not (true, this is the recommended behavior) , defaults to true (which is the recommended practice, but not the behavior of storage API). | `bool` | `true` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Enable versioning. | `bool` | `true` | no |
| <a name="input_website"></a> [website](#input\_website) | Bucket website. <br> <a name=main\_page\_suffix:></a>[main\_page\_suffix:](#main\_page\_suffix:) Behaves as the bucket's directory index where missing objects are treated as potential directories. <br> <a name=not\_found\_page:></a>[not\_found\_page:](#not\_found\_page:) The custom object to return when a requested resource is not found. | <pre>object({<br>    main_page_suffix = string<br>    not_found_page   = string<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | Bucket resource. |
| <a name="output_id"></a> [id](#output\_id) | Bucket ID (same as name). |
| <a name="output_name"></a> [name](#output\_name) | Bucket name. |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The URI of the created resource. |
| <a name="output_url"></a> [url](#output\_url) | Bucket URL. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Test

### Environment

Since most automated tests written with Terratest can make potentially destructive changes in your environment, we
strongly recommend running tests in an environment that is totally separate from production. For example, if you are
testing infrastructure code for GCP, you should run your tests in a completely separate GCP account.

### Requirements

Terratest uses the Go testing framework. To use terratest, you need to install:

* [Go](https://golang.org/) (requires version >=1.13)

### Running

Now you should be able to run the example test.

1. Change your working directory to the `test/src` folder.
1. Each time you want to run the tests:

```bash
go test -timeout 20m
```

### Terraform CLI

On the `examples/dummy` folder, perform the following commands.

* Get the plugins:

```bash
terraform init
```

* Review and apply the infrastructure test build:

```bash
terraform apply -var-file=fixtures.europe-west3.tfvars
```

* Remove all resources:

```bash
terraform destroy -auto-approve
```
