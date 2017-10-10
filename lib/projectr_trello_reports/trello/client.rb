module Trello
  class Client
    def board_cards(board_id)
      url = URI("https://api.trello.com/1/boards/#{board_id}/cards?cards=all&key=#{TRELLO_KEY}&token=#{TRELLO_TOKEN}")
      get_request(url)
    end

    def card_actions(card_id)
      url = URI("https://api.trello.com/1/cards/#{card_id}/actions?key=#{TRELLO_KEY}&token=#{TRELLO_TOKEN}")
      get_request(url)
    end

    private

    def get_request(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)

      response = http.request(request)
      JSON.parse(response.read_body)
    end
  end
end
