source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'dotenv-rails', groups: [:development, :test]

gem 'rails',      '6.0.2.1'
gem 'puma',       '3.12.4'
gem 'pg'
gem 'sass-rails', '5.1.0'
gem 'webpacker',  '4.0.7'
gem 'turbolinks', '5.2.0'
gem 'jbuilder',   '2.9.1'
gem 'jquery-rails'
gem 'bootsnap',   '1.4.5', require: false

gem 'activerecord-import'
gem 'bootstrap-sass', '3.4.1'
gem 'bootstrap',  '~>4.3.1'
gem 'simple_form'
gem 'momentjs-rails'
gem 'bootstrap4-datetime-picker-rails'
gem 'image_processing'


gem 'pry-byebug'
gem 'better_errors'
gem 'awesome_print'
gem 'faker'
gem 'hirb'
gem 'bcrypt',     '3.1.13'
gem 'random-password'
gem 'ruby-progressbar'

gem 'icalendar'
gem 'activesupport'
gem 'sendgrid-ruby'

# Use Devise for authentication
gem 'devise'
# Use Omniauth Facebook plugin
# gem 'omniauth-facebook'
# Use Omniauth Github plugin
gem 'omniauth-github'
# Use Omniauth Twitter plugin
gem 'omniauth-twitter'

gem 'omniauth-google-oauth2'
# gem 'google-api-client', require: 'google/apis/calendar_v3'

# Use ActiveRecord Sessions
gem 'activerecord-session_store'

gem "aws-sdk-s3", require: false

group :development, :test do
  gem 'byebug',  '11.0.1', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console',           '4.0.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'capybara',           '3.28.0'
  gem 'selenium-webdriver', '3.142.4'
  gem 'webdrivers',         '4.1.2'
  gem 'rails-controller-testing', '1.0.4'
  gem 'minitest',                 '5.11.3'
  gem 'minitest-reporters',       '1.3.8'
  gem 'guard',                    '2.15.0'
  gem 'guard-minitest',           '2.4.6'
end

group :production do
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]