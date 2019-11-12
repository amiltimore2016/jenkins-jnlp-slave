TERRAFORM_DIR = components/terraform
ENVIRONMENT?=development
TAG=?development
CURRENT_TAG = $(shell git rev-parse --abbrev-ref HEAD)

.PHONY: build push all clean test

ifeq: ($(CURRENT_TAG),master)
	TAG=release
	print ${TAG}
else:
	TAG=development
endif:

print-%  : ; @echo $* = $($*)

build_terraform:
	./jinja.sh ${ENVIRONMENT} ${CURRENT_TAG}
	$(MAKE) -C $(TERRAFORM_DIR) TAG=${TAG} build

teardown:
	$(MAKE) -C $(TERRAFORM_DIR) TAG=${TAG} clean

terraform_test:
	./jinja.sh ${ENVIRONMENT} ${CURRENT_TAG}
	$(MAKE) -C $(TERRAFORM_DIR) TAG=${TAG} test

