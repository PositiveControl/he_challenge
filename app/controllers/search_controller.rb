class SearchController < ApplicationController
  def index
    @search_history = last_ten_searches

    if params[:query]
      retrieve_or_create_search
      @query_results
    end
  end

  def show

  end

  private

  def last_ten_searches
    @last_ten_searches =
      Search.order(:updated_at).take(10)
  end

  def retrieve_or_create_search
    query = params[:query].upcase
    search_results = Search
      .find_by(:term => query)

    if search_results
     coin_data = Binance.coin_price(search_results.term + "USDT")
     search_results.update_attribute(:last_searched, DateTime.now)
     @query_results = search_results.reload
    else
      @query_results = Search.create(
        :term => query,
        :last_searched => DateTime.now
      )
    end
  end
end
