# require 'rest-client'
# require 'json'
# require 'pry'
require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'app'
require_all 'lib'
#API Key: 6A5C870F-0754-4F70-B631-3469A5642D07
