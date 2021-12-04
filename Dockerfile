FROM ruby:3.0.2

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -o Dpkg::Options::="--force-confold" \
    && apt-get install -y build-essential libpq-dev nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && truncate -s 0 /var/log/*log

RUN mkdir /dispatcher
WORKDIR /dispatcher

# Environment variables
ENV RAILS_ENV=${RAILS_ENV} \
    BUNDLER_VERSION=2.2.3

COPY Gemfile /dispatcher/Gemfile
COPY Gemfile.lock /dispatcher/Gemfile.lock

RUN gem install bundler -v ${BUNDLER_VERSION} \
    && bundle install --jobs 20 --retry 5

COPY . /dispatcher

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

EXPOSE 3000
