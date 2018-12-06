require 'uri'
require 'net/http'
require 'json'
require 'rest-client'
require 'pry'

require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'app'
require_all 'lib'
