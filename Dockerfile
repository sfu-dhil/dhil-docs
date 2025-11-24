FROM ruby:3.3
WORKDIR /app

# build ruby deps
COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app