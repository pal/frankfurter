FROM ruby:3.1.3

RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
ADD .ruby-version /app/.ruby-version
RUN gem install bundler
RUN bundle config set without "development test"
RUN bundle install --jobs=8
ADD . /app
CMD ["bundle", "exec", "unicorn -p $PORT -c ./config/unicorn.rb"]
