SHELL := /bin/bash

.PHONY: install-deps build-packages build-iso test-iso validate-packages validate-iso clean

install-deps:
	sudo ./scripts/install-build-dependencies.sh

build-packages:
	./scripts/build-packages.sh

build-iso:
	sudo ./scripts/build-iso.sh

test-iso:
	./scripts/test-iso.sh

validate-packages:
	./scripts/validate-packages.sh

validate-iso:
	./scripts/validate-iso.sh

clean:
	./scripts/clean.sh
