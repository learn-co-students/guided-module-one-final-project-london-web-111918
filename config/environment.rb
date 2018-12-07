require 'uri'
require 'net/http'
require 'json'
require 'rest-client'
require 'pry'
require 'rainbow'

require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
require_all 'app'
require_all 'lib'
