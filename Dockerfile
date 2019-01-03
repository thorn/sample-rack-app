FROM ruby:2.6.0-alpine3.8

RUN apk --no-cache add mysql-dev
RUN apk update && apk add build-base gcc

COPY ./app/* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install


CMD ["rackup", "/usr/src/app/server.rb"]
