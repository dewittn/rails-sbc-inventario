source 'https://rubygems.org'

ruby '2.7.8'

gem 'rails', '4.2.11.3'

# Database
gem 'mysql2', '~> 0.4.10' # Rails 4.2 and MySQL 8.0 compatible version
gem 'sqlite3', '~> 1.3.13' # For test environment

# Views
gem 'haml', '~> 5.0'

# Pagination
gem 'will_paginate', '~> 3.1.0'

# Page caching (extracted from Rails core in Rails 4)
gem 'actionpack-page_caching', '~> 1.1.0'
gem 'actionpack-action_caching', '~> 1.1.1'

# Authentication (replaces restful_authentication plugin)
gem 'bcrypt', '~> 3.1.7'

# Exception notification
gem 'exception_notification', '~> 4.1.0'

# Asset pipeline
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

# Prototype.js support for legacy drag-and-drop functionality
# Commented out - incompatible with Rails 4.2, will modernize later
# gem 'prototype-rails'

group :development, :test do
  gem 'byebug'
end

group :test do
  gem 'test-unit', '~> 3.0'
end
