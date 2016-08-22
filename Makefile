.PHONY: container test shellcheck try

container:
	docker build -t localn .

test: shellcheck try

shellcheck: container
	docker run --rm -it localn shellcheck /bin/localn

try: container
	docker run --rm -it localn /try.sh
