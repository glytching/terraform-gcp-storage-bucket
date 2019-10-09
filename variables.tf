variable "project_id" {
  description = "The ID of the project in which this bucket will be created. If this is not supplied then the project configured on the google provider will be used."
  default     = ""
}

variable "name" {
  description = "The name of the bucket. If this is not supplied then a name will be generated for you using a combination of var.project_id and a random suffix. This approach to naming is in accordance with GCS bucket naming best practices, see: https://cloud.google.com/storage/docs/best-practices#naming."
  default     = ""
}

variable "location" {
  description = "The location of the bucket, see: https://cloud.google.com/storage/docs/locations."
  default     = ""
}

variable "storage_class" {
  description = "The storage class of the bucket, see: https://cloud.google.com/storage/docs/storage-classes"
  default     = ""
}

variable "default_acl" {
  description = "The default ACL for the bucket, see: https://cloud.google.com/storage/docs/access-control/lists#predefined-acl."
  default     = ""
}

variable "predefined_acl" {
  description = "One of the canned bucket ACLs, see https://cloud.google.com/storage/docs/access-control/lists#predefined-acl for more details. Must be set if var.role_entity is not."
  default     = ""
}
variable "role_entity" {
  description = "List of role/entity pairs in the form ROLE:entity. See https://cloud.google.com/storage/docs/json_api/v1/bucketAccessControls for more details. Must be set if var.predefined_acl is not."
  default     = []
}

variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects. If you try to delete a bucket that contains objects, Terraform will fail that run."
  default     = false
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the bucket. See also:https://cloud.google.com/resource-manager/docs/creating-managing-labels#requirements."
  default     = {}
}

variable "bucket_policy_only" {
  description = "If true then Bucket Policy Only access is enabled on this bucket. See: https://cloud.google.com/storage/docs/bucket-policy-only."
  default     = "false"
}

variable "log_bucket" {
  description = "The name of the bucket to which access logs for this bucket should be written. If this is not supplied then no access logs are written."
  default     = ""
}

variable "log_object_prefix" {
  description = "The prefix for access log objects. If this is not provided then GCS defaults it to the name of the source bucket."
  default     = ""
}

variable "kms_key_sl" {
  description = "A self_link to a Cloud KMS key to be used to encrypt objects in this bucket, see also: https://cloud.google.com/storage/docs/encryption/using-customer-managed-keys. If this is not supplied then default encryption is used."
  default     = ""
}

variable "versioning_enabled" {
  description = "If true then versioning is enabled for all objects in this bucket."
  default     = "false"
}

variable "website_main_page_suffix" {
  description = "The name of a file in the bucket which will act as the 'index' page to be served by GCS if this bucket is hosting a static website. See also: https://cloud.google.com/storage/docs/hosting-static-website."
  default     = ""
}
variable "website_not_found_page" {
  description = "The name of the 'not found' page to be served by GCS if this bucket is hosting a static website. See also: https://cloud.google.com/storage/docs/hosting-static-website."
  default     = ""
}

variable "retention_policy_is_locked" {
  description = "If set to true, the bucket will be locked and any changes to the bucket's retention policy will be permanently restricted. Caution: Locking a bucket is an irreversible action."
  default     = "false"
}
variable "retention_policy_retention_period" {
  description = "The period of time, in seconds, that objects in the bucket must be retained and cannot be deleted, overwritten, or archived. The value must be less than 3,155,760,000 seconds. If this is supplied then a bucket retention policy will be created."
  default     = ""
}

variable "lifecycle_rules" {
  description = "The lifecycle rules to be applied to this bucket. If this array is populated then each element in it will be applied as a lifecycle rule to this bucket. The structure of each element is described in detail here: https://www.terraform.io/docs/providers/google/r/storage_bucket.html#lifecycle_rule. See also: https://cloud.google.com/storage/docs/lifecycle#configuration."
  default     = []
}

variable "cors_origins" {
  description = "The list of Origins eligible to receive CORS response headers. Note: '*' is permitted in the list of origins, and means 'any Origin'. See also: https://tools.ietf.org/html/rfc6454."
  type        = list(string)
  default     = []
}

variable "cors_methods" {
  description = "The list of HTTP methods on which to include CORS response headers, (GET, OPTIONS, POST, etc) Note: '*' is permitted in the list of methods, and means 'any method'."
  type        = list(string)
  default     = []
}

variable "cors_response_headers" {
  description = "The list of HTTP headers other than the simple response headers to give permission for the user-agent to share across domains."
  type        = list(string)
  default     = []
}

variable "cors_max_age_seconds" {
  description = "The value, in seconds, to return in the Access-Control-Max-Age header used in preflight responses."
  default     = 0
}