require 'rails_helper'

RSpec.describe Binance, :type => :model do
  context 'getting a ticker' do
    it 'retrieves the requested ticker and price' do
      query = 'ETHUSDT'
      response = Binance.coin_price(query)

      expect(response['symbol']).to eq(query)
      expect(response['price']).to be_present
    end
  end
end
