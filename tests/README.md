This module is tested using a deploy-then-assert approach:

* For each bucket attribute or attribute category, create a bucket
* Use the [InSpec GCP resource pack](https://github.com/inspec/inspec-gcp) to assert that the created bucket matches the test's expectations
  
The tests live in [fixtures](./fixtures). Other folders in this directory adhere to InSpec's convention:

* `controls`: contains the test assertions
* `files`: contains inputs to the test assertions   
  
### Anatomy of a Test

Taking the [basic](./fixtures/basic) as an example:

* A bucket is created with the following inputs:
    ```
    location           = var.location
    storage_class      = var.storage_class
    versioning_enabled = var.versioning
    ```
* The values of those inputs and the name of the created bucket are declared as Terraform outputs
* After the bucket is created:
  * The outputs are written to the `files` directory
  * InSpec is invoked and it runs the [GCS control](./controls/gcs.rb) which ...
     1. Reads the Terraform outputs 
     1. Uses these outputs to load the bucket definition and assert that its attributes match the values expected by the test
* On completion of the assertions, the bucket is deleted

### Test Logging

The output of a test run looks like this:

```
$ ./test.sh -t basic
Running test: terraform-gcp-storage-bucket/tests/fixtures/basic
Initializing modules...
- bucket in ../../..

<snip>

Terraform has been successfully initialized!

module.bucket.data.google_client_config.default: Refreshing state...
module.bucket.random_id.default: Creating...
module.bucket.random_id.default: Creation complete after 0s [id=NVs]
module.bucket.google_storage_bucket.default: Creating...
module.bucket.google_storage_bucket.default: Creation complete after 2s 

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

bucket_location = europe-west2
bucket_name = provoked-tarantula-212614-13659
bucket_storage_class = REGIONAL
number_of_buckets = 1
project_id = provoked-tarantula-212614
versioning_enabled = true

Profile: Tests for the terraform-gcp-storage-bucket Terraform module (storage-bucket-module-tests)
Version: 0.1.0

  ✔  gcs-bucket: Ensure that the bucket is created correctly
     ✔  Bucket provoked-tarantula-212614-13659 should exist
     ✔  Bucket provoked-tarantula-212614-13659 id should eq "provoked-tarantula-212614-13659"
     ✔  Bucket provoked-tarantula-212614-13659 kind should eq "storage#bucket"
     ✔  Bucket provoked-tarantula-212614-13659 storage_class should eq "REGIONAL"
     ✔  Bucket provoked-tarantula-212614-13659 location should cmp == "europe-west2"
     ✔  true should cmp == "true"
  ✔  gcs-buckets: Ensure the correct number of buckets are created
     ✔  google_storage_buckets count should cmp == "1"


Profile: Google Cloud Platform Resource Pack (inspec-gcp)
Version: 0.15.1

     No tests executed.

Profile Summary: 2 successful controls, 0 control failures, 0 controls skipped
Test Summary: 7 successful, 0 failures, 0 skipped
module.bucket.random_id.default: Refreshing state... [id=NVs]
module.bucket.data.google_client_config.default: Refreshing state...
module.bucket.google_storage_bucket.default: Refreshing state... [id=provoked-tarantula-212614-13659]
module.bucket.google_storage_bucket.default: Destroying... [id=provoked-tarantula-212614-13659]
module.bucket.google_storage_bucket.default: Destruction complete after 1s
module.bucket.random_id.default: Destroying... [id=NVs]
module.bucket.random_id.default: Destruction complete after 0s

Destroy complete! Resources: 2 destroyed.
Passed test: terraform-gcp-storage-bucket/tests/fixtures/basic
OK (1 test(s) passed)
```  
  
### Test Orchestration

The [test runner](./test.sh) allows you to run one test or all tests, for example:
```
# run one test
./test.sh -t basic

# run all tests
./test.sh
```

The test runner is a `bash` script so if you're not running on a `bash` compatible system then you could either:

* Create (and contribute!) an equivalent of the [test runner](./tests/test.sh) for your system
* Run each test manually, as follows:
    ```
    cd tests/<fixture_name>
    
  terraform init
    terraform destroy -auto-approve
    terraform apply  -auto-approve
    terraform output --json > ../../files/terraform_outputs.json
    
    inspec vendor ../../ --overwrite --log-level=error
    inspec check ../../  --log-level=error
    inspec exec ../../ -t gcp:// --show-progress --log-level=warn
    ```
  
##### Notes

* Every test expects the following Terraform variables to be populated:
```
  credentials = var.project_editor_key
  project     = var.project_id
```
* The InSpec phase assumes that you are already auth'ed using GOOGLE_APPLICATION_CREDENTIALS with a user/SA who has viewer access to the target project  

There is no publicly available GCP project for this module so anyone running the tests will need to provide a project id and SA key for their own test project. There is ~no cost impact here since the test buckets only exist briefly and they never contain any objects. 
Assuming you have a GCP project and SA key, you can supply it to a test by creating a `personal.auto.tfvars` file in the test fixture directory like so:

```hcl-terraform
project_id         = "your-project-id"
project_editor_key = <<EOF
{
  <snip>>
}
EOF

``` 
 
  