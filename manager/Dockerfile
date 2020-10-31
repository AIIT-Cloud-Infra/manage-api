FROM ruby:2.7.2-alpine3.12

RUN apk add --no-cache \
  build-base \
  libxml2-dev \
  libxslt-dev \
  mariadb-dev \
  tzdata

WORKDIR /manager_api
EXPOSE 3000
