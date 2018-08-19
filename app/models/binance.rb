require 'net/http'

class Binance
  def self.coin_price(coin_pair)
    uri = URI('https://api.binance.com/api/v3/ticker/price')
    params = { :symbol => coin_pair }
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
