source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# System
gem 'bootsnap', require: false
gem 'pg'
gem 'puma'
gem 'rack-cors'
gem 'rails'
gem 'tzinfo-data'

# Trailblazer bundle
gem 'dry-types'
gem 'dry-validation', '0.11.1'
gem 'trailblazer-rails'

# GraphQL server
gem 'graphql'

# Authentification
gem 'bcrypt'
gem 'jwt'

# File uploader
gem 'apollo_upload_server', '2.0.0.beta.1'
gem 'carrierwave'

# Authorization
gem 'pundit'

group :development, :test do
  gem 'awesome_print'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers'
end

group :development do
  gem 'bullet'
  gem 'bundle-audit'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'

  # GraphQL server
  gem 'coffee-rails'
  gem 'graphiql-rails'
  gem 'sass-rails'
  gem 'uglifier'
end

group :test do
  gem 'pronto', require: false
  gem 'pronto-brakeman', require: false
  gem 'pronto-fasterer', require: false
  gem 'pronto-rails_best_practices', require: false
  gem 'pronto-rails_schema', require: false
  gem 'pronto-rubocop', require: false
  gem 'pronto-scss', require: false
  gem 'rails-controller-testing'
  gem 'rspec_junit_formatter'
  gem 'simplecov', require: false
end
