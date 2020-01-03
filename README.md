# terraform-gcp-storage-bucket

A Terraform module for creating GCS buckets.

This module:

* Covers all of the attributes exposed by Terraform's [`google_storage_bucket`](https://www.terraform.io/docs/providers/google/r/storage_bucket.html) resource:
  * location
  * storage class
  * logging
  * lifecycle rules
  * retention_policy
  * encryption
  * versioning
  * cors
  * website
* Allows the caller to manage bucket ACL, using Terraform's [`google_storage_bucket_acl` resource](https://www.terraform.io/docs/providers/google/r/storage_bucket_acl.html)
* Uses Terraform v0.12 [dynamic blocks](https://www.terraform.io/docs/configuration/expressions.html#dynamic-blocks) to manage optional blocks such as lifecycle rules, encryption etc.
* Is [fully tested](./tests/README.md)

See also [GCS documentation](https://cloud.google.com/storage/docs/).

Usage
-------

See [examples](./examples).

Inputs
-------

| Name | Description | Type | Default | Required |
|:-----|:------------|:----:|:-------:|:--------:|
|project_id|The ID of the project in which this bucket will be created. If this is not supplied then the project configured on the google provider will be used.|string|`""`|N| 
|name|The name of the bucket. If this is not supplied then a name will be generated for you using a combination of var.project_id and a random suffix. This approach to naming is in accordance with [GCS bucket naming best practices](https://cloud.google.com/storage/docs/best-practices#naming).|string|`""`|N|
|location|The location of the bucket, more details [here](https://cloud.google.com/storage/docs/locations).|string|`""`|N|
|storage_class|The storage class of the bucket, more details [here](https://cloud.google.com/storage/docs/storage-classes)|string|`""`|N|
|default_acl|The default ACL for the bucket, more details [here](https://cloud.google.com/storage/docs/access-control/lists#predefined-acl).|string|`""`|N|
|predefined_acl|One of the canned bucket ACLs, more details [here](https://cloud.google.com/storage/docs/access-control/lists#predefined-acl). Must be set if `var.role_entity` is not.|string|`""`|N|
|role_entity|List of role/entity pairs in the form `ROLE:entity`. More details [here](https://cloud.google.com/storage/docs/json_api/v1/bucketAccessControls) for more details. Must be set if `var.predefined_acl` is not.|list|`[]`|N|
|force_destroy|When deleting a bucket, this boolean option will delete all contained objects. If you try to delete a bucket that contains objects, Terraform will fail that run.|boolean|`false`|N|
|labels|A set of key/value label pairs to assign to the bucket. More details [here](https://cloud.google.com/resource-manager/docs/creating-managing-labels#requirements).|list|`[]`|N|
|bucket_policy_only|If true then Bucket Policy Only access is enabled on this bucket. More details [here](https://cloud.google.com/storage/docs/bucket-policy-only).|boolean|`false`|N|
|log_bucket|The name of the bucket to which access logs for this bucket should be written. If this is not supplied then no access logs are written.|string|`""`|N|
|log_object_prefix|The prefix for access log objects. If this is not provided then GCS defaults it to the name of the source bucket.|string|`""`|N|
|kms_key_sl|A self_link to a Cloud KMS key to be used to encrypt objects in this bucket, more details [here](https://cloud.google.com/storage/docs/encryption/using-customer-managed-keys). If this is not supplied then default encryption is used.|string|`""`|N|
|versioning_enabled|If true then versioning is enabled for all objects in this bucket.|boolean|`false`|N|
|website_main_page_suffix|The name of a file in the bucket which will act as the 'index' page to be served by GCS if this bucket is hosting a static website. More details [here](https://cloud.google.com/storage/docs/hosting-static-website).|string|`""`|N|
|website_not_found_page|The name of the 'not found' page to be served by GCS if this bucket is hosting a static website. More details [here](https://cloud.google.com/storage/docs/hosting-static-website).|string|`""`|N|
|retention_policy_is_locked|If set to true, the bucket will be locked and any changes to the bucket's retention policy will be permanently restricted. Caution: Locking a bucket is an irreversible action.|boolean|`false`|N|
|retention_policy_retention_period|The period of time, in seconds, that objects in the bucket must be retained and cannot be deleted, overwritten, or archived. The value must be less than 3,155,760,000 seconds. If this is supplied then a bucket retention policy will be created.|string|`""`|N|
|lifecycle_rules|The lifecycle rules to be applied to this bucket. If this array is populated then each element in it will be applied as a lifecycle rule to this bucket. The structure of each element is described in detail [here](https://www.terraform.io/docs/providers/google/r/storage_bucket.html#lifecycle_rule). More details [here](https://cloud.google.com/storage/docs/lifecycle#configuration).|list|`[]`|N|
|cors_origins|The list of Origins eligible to receive CORS response headers. Note: '*' is permitted in the list of origins, and means 'any Origin'.|string|`""`|N|
|cors_methods|The list of HTTP methods on which to include CORS response headers, (GET, OPTIONS, POST, etc) Note: '*' is permitted in the list of methods, and means 'any method'.|string|`""`|N|
|cors_response_headers|The list of HTTP headers other than the simple response headers to give permission for the user-agent to share across domains.|string|`""`|N|
|cors_max_age_seconds|The value, in seconds, to return in the Access-Control-Max-Age header used in preflight responses.|int|`0`|N|

Outputs
-------

| Name | Description |
|:-----|:------------|
|name|The name of the bucket created by this module|
|self_link|The self link of the bucket created by this module|
|url|The base URL of the bucket created by this module, in the form gs://<name>|

Contributing
-------

* [Contributing To This Project](.github/CONTRIBUTING.md)
* [Code Of Conduct For This Project](.github/CODE_OF_CONDUCT.md)
* [Issue Template](.github/ISSUE_TEMPLATE.md)
* [Pull Request Template](.github/PULL_REQUEST_TEMPLATE.md)
* [License](LICENSE)
* Module layout follows the [Terraform standard conventions](https://www.terraform.io/docs/modules/index.html)
* HCL follows the [Terraform style guide](https://www.terraform.io/docs/configuration/style.html)
* [Install Terraform](https://www.terraform.io/downloads.html) v0.12.x
* [Install InSpec](https://www.inspec.io/downloads/) (tested with v4.17.17)
* [Test your changes](./tests/README.md)

License
-------

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.      