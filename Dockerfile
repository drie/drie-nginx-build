FROM heroku/cedar:14
LABEL maintainer "drie"

RUN apt-get -y update
RUN apt-get install -y ruby2.0 ruby2.0-dev rake

ADD scripts/build_nginx.sh /tmp/build_nginx.sh
RUN /tmp/build_nginx.sh
