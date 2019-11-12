CURRENT_TAG = $(shell git describe --tags `git rev-list --tags --max-count=1`)

build: test
	terraform plan 
	terraform apply -auto-approve

test: init
	terraform validate
	terraform plan

clean:
	terraform destroy -auto-approve

init:
	terraform init

all: test build

.PHONY: test clean build

