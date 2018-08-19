class Search < ApplicationRecord
  has_many :search_instances
  validates_presence_of :term
  validates_uniqueness_of :term
  before_save :validate_query
  after_save :create_search_instance

  attr_accessor :binance_coin_data

  def times_searched
    self.search_instances.count
  end

  private

  def validate_query
    @binance_coin_data = Binance.coin_price(self.term + "USDT")

    if binance_coin_data["msg"]
      throw :abort
    end
  end

  def create_search_instance
    SearchInstance.create(
      :search_id => self.id,
      :result => binance_coin_data["price"]
    )
  end
end
