require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/kitchen.db')
require_all './app'
require_relative '../lib/cli_methods'

ActiveRecord::Base.logger.level = 1

result = []
