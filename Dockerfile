FROM debian:latest
RUN apt-get update && apt-get install -y wget shellcheck
ADD src/localn.sh /bin/localn
RUN chmod +x /bin/localn
ADD try.sh /
RUN chmod +x /try.sh
