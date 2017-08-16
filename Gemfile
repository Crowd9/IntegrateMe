source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.9'
# Rake 11.0.1 removes the last_comment method which rspec-core (< 3.4.4) uses
gem 'rake', '< 11.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
#Use Bootstrap style
gem 'bootstrap-sass', '~> 3.3.6'
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

# ActiveModelSerializers brings convention over configuration to your JSON generation. see: https://github.com/rails-api/active_model_serializers
gem 'active_model_serializers', '~> 0.10.0'
# A plugin for versioning Rails based RESTful APIs. see: https://github.com/bploetz/versionist
gem 'versionist', '~> 1.5.0'

# Gibbon is an API wrapper for MailChimp's API.
gem 'gibbon'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Slugging and permalink plugins for ActiveRecord
gem 'friendly_id', '~> 5.1.0'

# Ruby gem to handle settings for ActiveRecord instances by storing them as serialized Hash in a separate database table.
gem 'ledermann-rails-settings'

# Authorization
gem 'devise'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.3.3'
  gem 'faker', '~> 1.8.4'
  gem 'factory_girl_rails', '~> 4.8.0'
  gem 'capybara', '~> 2.15'
  gem 'jasmine'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
