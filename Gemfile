source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.1"

gem "rails", "~> 6.1.4", ">= 6.1.4.6"

gem "sqlite3", "~> 1.4"

gem "puma", "~> 5.0"

gem "sass-rails", ">= 6"

gem "bootstrap-sass", "~> 3.4", ">= 3.4.1"

gem "webpacker", "~> 5.0"

gem "turbolinks", "~> 5"

gem "jbuilder", "~> 2.7"

gem "bcrypt", "~> 3.1.7"

gem "bootsnap", ">= 1.4.4", require: false

gem "i18n", "~> 1.10"

gem "config", "~> 4.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]

  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
end

group :development do
  gem "listen", "~> 3.3"
  gem "web-console", ">= 4.1.0"

  gem "rack-mini-profiler", "~> 2.0"

  gem "spring"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"

  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
