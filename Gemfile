source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'angularjs-rails'
gem 'angular_rails_csrf'
gem 'bower-rails'
gem 'angular-rails-templates'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Decorators
gem 'draper'

# Email validator
gem 'email_validator'

# jQuery
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Templates
gem 'haml-rails', '~> 0.9'

# Integrations gems
gem 'mailchimp-api', require: 'mailchimp'

gem 'responders'

# Background jobs
gem 'sidekiq'
gem 'sinatra', require: nil

# Twitter Bootstrap
gem 'therubyracer'
gem 'less-rails' #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'twitter-bootstrap-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 3.3.3'
end

group :development do
  gem 'foreman'
  gem 'thin'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'capybara'
  gem 'mocha', '~> 1.1', require: false
  gem 'mock_redis', '~> 0.15.1'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'poltergeist', '~> 1.9.0'
  gem 'rspec-activemodel-mocks', '~> 1.0', '>= 1.0.2'
  gem 'rspec-collection_matchers', '~> 1.1.2'
  gem 'rspec-given', '~> 3.7.0'
  gem 'rspec-its'
  gem 'rspec-mocks'
  gem 'rspec-sidekiq', '~> 2.2.0'
  gem 'rspec_junit_formatter', '0.2.2'
  gem 'shoulda-matchers', '~> 2.8.0'
  gem 'vcr'
  gem 'webmock', '~> 1.21.0'
end
