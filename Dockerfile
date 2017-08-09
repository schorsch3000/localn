FROM debian:latest
RUN apt-get update && apt-get install -y wget shellcheck curl make jq
RUN wget -qO - https://raw.github.com/rylnd/shpec/master/install.sh | bash
ADD semver /bin
ADD src/localn.sh /bin/localn
RUN chmod +x /bin/localn
ADD shpec /

WORKDIR /
