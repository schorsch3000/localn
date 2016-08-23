.PHONY: container test shellcheck try drone
test: shellcheck try


container:
	docker build -t localn .


shellcheck: container
	docker run --rm -it localn shellcheck /bin/localn

try: container
	docker run --rm -it localn /try.sh

drone:
	rm -rf .localn
	shellcheck src/*.sh
	cp -rp src/localn.sh /bin/localn
	./try.sh
	rm -rf .localn

login: container
	docker run --rm -v "$(PWD)/src/localn.sh:/bin/localn" -it localn /bin/bash
