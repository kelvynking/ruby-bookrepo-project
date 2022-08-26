#import items in 'Gemfile'
require 'bundler/setup'
Bundler.require

#create connection to database
ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/development.sqlite3'
)

require_relative '../app/models/user.rb'
require_relative '../app/models/genre.rb'
require_relative '../app/models/book.rb'
require_relative '../app/cli.rb'
require_relative '../app/loggedinuser.rb'
require_relative '../app/scraper.rb'