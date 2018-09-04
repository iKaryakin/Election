FROM ruby:2.5

# Install Node
RUN apt-get update
RUN apt-get install curl
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN apt-get install --yes nodejs

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev vim mysql-client \ 
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY . /app
COPY docker-entrypoint.sh /usr/local/bin/
COPY wait-for-it.sh /usr/local/bin/


