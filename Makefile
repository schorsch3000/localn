.PHONY: container test shellcheck try drone
test: shellcheck test


container:
	docker build -t localn .


shellcheck: container
	docker run --rm -it localn shellcheck /bin/localn

test: container
	docker run --rm -it localn bash /usr/local/bin/shpec

drone:
	rm -rf .localn
	shellcheck src/*.sh
	cp -rp src/localn.sh /bin/localn
	shpec

login: container
	docker run --rm -v "$(PWD)/src/localn.sh:/bin/localn" -it localn /bin/bash
