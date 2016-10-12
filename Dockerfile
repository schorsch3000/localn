FROM debian:latest
RUN apt-get update && apt-get install -y wget shellcheck curl make
RUN wget -qO - https://raw.github.com/rylnd/shpec/master/install.sh | bash
ADD src/localn.sh /bin/localn
RUN chmod +x /bin/localn
ADD shpec /
WORKDIR /
