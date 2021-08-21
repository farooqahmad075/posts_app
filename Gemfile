# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.4'

gem 'dotenv'
gem 'faker'
gem 'httparty'
gem 'nokogiri'
gem 'pg'
gem 'puma'
gem 'sequel'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'whenever', require: false

group :development do
  gem 'rubocop', '~> 1.19', require: false
end

group :development, :test do
  gem 'factory_bot'
  gem 'pry', '~> 0.13.1'
end

group :test do
  gem 'rspec'
end
