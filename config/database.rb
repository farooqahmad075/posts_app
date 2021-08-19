# frozen_string_literal: true

DB = Sequel.connect(adapter: ENV['DB_ADAPTER'], database: ENV['DB_NAME'], host: ENV['DB_HOST'])
