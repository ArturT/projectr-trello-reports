require 'dotenv/load'
require 'json'
require 'uri'
require 'net/http'

require_relative 'projectr_trello_reports/trello/client'

TRELLO_KEY = ENV.fetch('TRELLO_KEY')
TRELLO_TOKEN = ENV.fetch('TRELLO_TOKEN')
TRELLO_BOARD_ID = ENV.fetch('TRELLO_BOARD_ID')
TRELLO_COLUMN_START = ENV.fetch('TRELLO_COLUMN_START')
TRELLO_COLUMN_END = ENV.fetch('TRELLO_COLUMN_END')

trello_client = Trello::Client.new
cards = trello_client.board_cards(TRELLO_BOARD_ID)
#puts JSON.pretty_generate(cards)

completed_cards = []

cards.each do |card|
  puts "Card ID: #{card['id']}"
  actions = trello_client.card_actions(card['id'])
  #puts JSON.pretty_generate(actions)

  # ensure card was started by moving to start column in Trello
  start_action = actions.select do |action|
    list_after = action['data']['listAfter']
    list_after && list_after['name'] == TRELLO_COLUMN_START
  end.first

  next unless start_action
  puts 'Found start date.'

  # ensure card was done by moving to end column in Trello
  end_action = actions.select do |action|
    list_after = action['data']['listAfter']
    list_after && list_after['name'] == TRELLO_COLUMN_END
  end.first

  next unless end_action
  puts 'Found end date.'

  completed_cards << OpenStruct.new(
    card: card,
    actions: actions,
    start_action: start_action,
    end_action: end_action,
    start_date: start_action['date'],
    end_date: end_action['date'],
  )
  puts
end


puts "All cards in Trello board: #{cards.size}"
puts "Completed cards in Trello board: #{completed_cards.size}"
