#import items in 'Gemfile'
require 'bundle/setup'
Bundler.require

#create connection to database
ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/development.sqlite3'
)