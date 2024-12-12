# frozen_string_literal: true

source "https://rubygems.org"

ruby File.read(".ruby-version").chomp

gem "money"
gem "oj"
gem "ox"
gem "rack-cors"
gem "rake"
gem "roda"
gem "rufus-scheduler"
gem "sequel"
gem "sqlite3"
gem "unicorn"

group :development, :test do
  gem "rubocop-minitest"
  gem "rubocop-performance"
  gem "rubocop-rake"
  gem "rubocop-sequel"
  gem "rubocop-shopify"
end

group :test do
  gem "minitest"
  gem "minitest-around"
  gem "minitest-focus"
  gem "rack-test"
  gem "vcr"
  gem "webmock"
end
