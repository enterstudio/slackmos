ruby "2.3.1"

source "https://rubygems.org"

gem "rails", "~> 7.1"

gem "addressable"
gem "coffee-rails", "~> 4.2.2"
gem "fernet"
gem "jbuilder", "~> 2.6", ">= 2.6.4"
gem "jquery-rails", ">= 4.2.0"
gem "listen", ">= 3.1.4"
gem "lograge", ">= 0.9.0"
gem "omniauth-github", ">= 2.0.0"
gem "omniauth-google-oauth2", ">= 0.4.1"
gem "omniauth-heroku", "1.0.0"
gem "omniauth-slack", "2.3.0"
gem "pg"
gem "puma"
gem "rake", "<11.0"
gem "rails_stdout_logging", "0.0.5"
gem "redis", "~> 3.0"
gem "sidekiq"
gem "sass-rails", "~> 6.0", ">= 6.0.0"
gem "turbolinks", ">= 5.0.0"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "brakeman"
  gem "byebug"
  gem "dotenv-rails", ">= 2.7.6"
  gem "pry"
  gem "rspec-rails", "3.5.0"
  gem "rubocop"
end

group :test do
  gem "webmock", require: false
  gem "capybara", ">= 2.8.0"
  gem "codeclimate-test-reporter", require: nil
end

group :development do
  gem "foreman"
  gem "spring"
  gem "web-console", "~> 3.2", ">= 3.2.0"
end

group :staging, :production do
  gem "rails_12factor"
end
