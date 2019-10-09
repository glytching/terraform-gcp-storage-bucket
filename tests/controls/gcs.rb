# read the test inputs, produced by the 'terraform output --json' command
require_relative '../utils/test_inputs_reader.rb'
test_inputs = TestInputsReader.new(inspec.profile.file('terraform_outputs.json'))
has_acl = test_inputs.get_or_default("has_acl", "false")

title 'Test GCS resources for bucket module'

control 'gcs-bucket' do
    impact 1.0
    title 'Ensure that the bucket is created correctly'
    desc 'See title'

    bucket = google_storage_bucket(name: test_inputs.bucket_name)

    describe bucket do
        it { should exist }
        its('id') { should eq test_inputs.bucket_name }
        its('kind') { should eq 'storage#bucket' }
        its ('storage_class') { should eq test_inputs.bucket_storage_class }
        its ('location') { should cmp test_inputs.bucket_location }
    end

    if test_inputs.get('versioning_enabled') != ''
        describe bucket.versioning.enabled do
            it { should cmp test_inputs.get_or_default('versioning_enabled', 'false') }
        end
    end

    if test_inputs.get('logging_bucket_name') != ''
        describe bucket.logging do
            its ('log_bucket') { should eq test_inputs.get('logging_bucket_name')}
            its ('log_object_prefix') { should eq test_inputs.get('logging_object_prefix')}
        end
    end

    if test_inputs.get('retention_period') != ''
        describe bucket.retention_policy do
            its ('retention_period') { should cmp test_inputs.get('retention_period')}
            its ('is_locked') { should cmp test_inputs.get('is_locked')}
        end
    end

    if test_inputs.get('main_page_suffix') != ''
        describe bucket.website do
            its ('main_page_suffix') { should eq test_inputs.get('main_page_suffix')}
            its ('not_found_page') { should eq test_inputs.get('not_found_page')}
        end
    end

    if test_inputs.get('has_labels') == 'true'
        bucket.labels.item.each do |key, value|
            describe key do
                it { should eq 'this' }
            end
            describe value do
                it { should eq 'that' }
            end
        end
    end

    if test_inputs.get('has_cors') == 'true'
        describe bucket.cors_configurations.first do
            its ('max_age_seconds') { should cmp test_inputs.get('max_age_seconds') }
            its ('origin') { should cmp test_inputs.get('origins') }
            its ('response_header') { should cmp test_inputs.get('response_headers') }
            its ('http_method') { should cmp test_inputs.get('http_methods') }
        end
    end
end

control 'gcs-buckets' do
    impact 1.0
    title 'Ensure the correct number of buckets are created'
    desc 'See title'

    describe google_storage_buckets(project: test_inputs.project_id) do
        its('count') { should cmp test_inputs.number_of_buckets}
    end
end