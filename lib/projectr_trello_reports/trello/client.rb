module Trello
  class Client
    def board_cards(board_id)
      url = URI("https://api.trello.com/1/boards/#{board_id}/cards?cards=all&key=#{TRELLO_KEY}&token=#{TRELLO_TOKEN}")
      cache_get_request(url)
    end

    def card_actions(card_id)
      url = URI("https://api.trello.com/1/cards/#{card_id}/actions?key=#{TRELLO_KEY}&token=#{TRELLO_TOKEN}")
      cache_get_request(url)
    end

    private

    def cache_get_request(url)
      cache_file = "tmp/#{Digest::SHA1.hexdigest(url.to_s)}.json"

      if CACHE_ENABLED && File.exist?(cache_file)
        response = File.read(cache_file)
      else
        response = get_request(url)
        File.write(cache_file, response)
      end

      JSON.parse(response)
    end

    def get_request(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)

      response = http.request(request)
      response.read_body
    end
  end
end
