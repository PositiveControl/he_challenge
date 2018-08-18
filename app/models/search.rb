class Search < ApplicationRecord
  validates_presence_of :term
  validates_uniqueness_of :term
  before_save :validate_ticker, :set_current_attributes

  attr_accessor :binance_coin_data

  private

  def validate_ticker
    @binance_coin_data = Binance.coin_price(self.term + "USDT")

    if binance_coin_data["msg"]
      throw :abort
    end
  end

  def set_current_attributes
    if self.times_searched.nil?
      self.times_searched = 1

    else
      self.times_searched = self.times_searched + 1
    end
  end
end
