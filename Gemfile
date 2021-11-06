# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv', '~> 2.1', '>= 2.1.1'
  # It manage local enveiroments var on development and tests
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# style
gem 'haml-rails', '~> 2.0'
# its a generator html/erb to haml
gem 'simple_form'
# easy to build flexibles forms components
gem 'pagy'
# make the pagination managment, like the nav pages in course index, and managing the items that are showed

# database
gem 'faker'
# it helps to fill database with fake data based on quotes from many places like series, movies...
gem 'friendly_id', '~> 5.2.4'
# it make entity access url friendly to users like "app.com/47146547" its converted to "app.com/usernamefulano"
gem 'ransack'
# used to build advanceds and simple searchs forms

# auth
gem 'devise'
# it work all registration, login, auth and more in the application
gem 'rolify'
# it's responsible to roles, that roles used by users(admin, teacher...) 
gem 'pundit'
# it's an authorization gem, it makes similar to can can can

# general_tools
gem 'public_activity'
# tracks users activity (we can say that notifications systems like that in instagram heart symbol works like this gem)
gem 'exception_notification'
# it catch application errors when users discover them and send me(app owner) a email with details about the error
