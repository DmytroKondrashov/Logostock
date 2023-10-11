source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "bootsnap", require: false
gem 'carrierwave', '~> 3.0'
gem "importmap-rails"
gem "jbuilder"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.8"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "font-awesome-sass", "~> 6.4.2"

gem "administrate", "~> 0.17.0"
gem 'administrate-field-carrierwave', '~> 0.6.0'

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rubocop"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

gem "devise", "~> 4.9"
