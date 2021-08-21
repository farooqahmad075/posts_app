# frozen_string_literal: true

DB = if ENV['RACK_ENV'] == 'test'
       Sequel.connect(adapter: ENV['TEST_DB_ADAPTER'], database: ENV['TEST_DB_NAME'], host: ENV['TEST_DB_HOST'])
     else
       Sequel.connect(adapter: ENV['DB_ADAPTER'], database: ENV['DB_NAME'], host: ENV['DB_HOST'])
     end
