.PHONY: container test shellcheck try drone
test: shellcheck shpec


container: semver
	docker build -t localn .

shellcheck: container
	@echo
	@echo
	@echo ------------------------------
	@echo  Running shellcheck
	@echo ------------------------------
	docker run --rm -it localn shellcheck /bin/localn

shpec: container
	@echo ------------------------------
	@echo  Running shpec
	@echo ------------------------------
	docker run --rm -it localn bash /usr/local/bin/shpec



login: container
	docker run --rm -v "$(PWD)/src/localn.sh:/bin/localn" -it localn /bin/bash

semver: mksemver.sh
	./mksemver.sh
