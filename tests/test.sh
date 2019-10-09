#!/bin/bash
set +x

TESTS_FAILED=0
TESTS_RUN=0

function usage() {
    echo 'Usage:'
    echo '  ./test.sh [-t]'
    echo ''
    echo 'Where:'
    echo '  -t the name of a folder in fixtures, if you specify this then only that test will be run, otherwise all tests are run'
    echo ''
    exit 1
}

function test_report() {
    if [[  $TESTS_FAILED -ne 0 ]]; then
        echo -e "FAIL ($TESTS_FAILED / $TESTS_RUN test(s) failed)"
        exit 1
    else
        echo -e "OK ($TESTS_RUN test(s) passed)"
        exit 0
    fi
}

function test() {
    local test_dir="${1}"

    cd "$test_dir" || exit
    echo "Running test: $test_dir"

    (( TESTS_RUN++ ))

    terraform fmt
    terraform init

    # just in case the resources already exist
    terraform destroy -auto-approve || exit

    # apply the fixture
    terraform apply -auto-approve || exit

    # grab the outputs
    terraform output --json > ../../files/terraform_outputs.json

    # run inspec, assumes that you are already auth'ed using GOOGLE_APPLICATION_CREDENTIALS with a user/SA who has
    # viewer access to the target project
    inspec vendor ../../ --overwrite --log-level=error
    inspec check ../../  --log-level=error
    inspec exec ../../ -t gcp:// --show-progress --log-level=warn
    test_response=$?

    # clean up
    terraform destroy -auto-approve
    rm -rf .terraform
    rm -f terraform.tfstate*
    rm -f ../../files/terraform_outputs.json

    # the 'ok' responses are 0 (all good) and 101 (good with some warnings)
    # anything other than these codes is deemed a failure
    if ! (( "$test_response" == 0 || "$test_response" == 101 )); then
       (( TESTS_FAILED++ ))
        echo "Failed test: $test_dir"
    else
        echo "Passed test: $test_dir"
    fi
}

function tests() {
    local test_name="${1}"

    BASEDIR="$PWD"
    if [[ "$test_name" == "" ]]; then
        # if a test_name is not supplied then iterate over all test fixtures and run each one
        for test_dir in "$BASEDIR"/fixtures/*/
        do
            if [[ -d "$test_dir" ]]; then
                test "$test_dir"
            fi
        done
    else
        # if a test_name is supplied then run the named test
        test "$BASEDIR"/fixtures/"$test_name"
    fi

    # report on success/failure
    test_report
}

function main() {
    while getopts ":t:" opt; do
        case $opt in
            t) test_name="$OPTARG"
            ;;
            \?) echo "Invalid option: -$OPTARG" >&2
                usage
                exit 1
            ;;
        esac
    done

    tests "${test_name:-""}"
}

main "$@"
