require 'dotenv/load'

# or
require 'dotenv'
Dotenv.load

TRELLO_KEY = ENV.fetch('TRELLO_KEY')
TRELLO_TOKEN = ENV.fetch('TRELLO_TOKEN')
