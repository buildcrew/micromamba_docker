setup_file() {
    load 'test_helper/common-setup'
    _common_setup
    docker build --quiet \
                 --tag=micromamba:test \
		 --file=${PROJECT_ROOT}/Dockerfile \
		 "$PROJECT_ROOT" > /dev/null
    docker build --quiet \
                 --tag=run-exec-form \
		 --file=${PROJECT_ROOT}/test/run-exec-form.Dockerfile \
		 "${PROJECT_ROOT}/test" > /dev/null
}

setup() {
    load 'test_helper/common-setup'
    _common_setup
}

@test "RUN [\"python\", \"-c\", \"import os; os.system('touch foobar')\"]" {
    run docker run --rm run-exec-form ls -1 foobar
    assert_output 'foobar'
}
