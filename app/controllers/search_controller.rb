class SearchController < ApplicationController
  before_action :last_ten_searches, :only => [:index, :show]

  def index
    if params[:query]
      retrieve_or_create_search
      @query_results
    end
  end

  def show
    @search = retrieve_search_object
  end

  private

  def last_ten_searches
    @search_history =
      Search.order(:updated_at).take(10)
  end

  def retrieve_or_create_search
    query = params[:query].upcase
    search_results = Search.find_by(:term => query)

    if search_results
     search_results.update_attribute(:last_searched, DateTime.now)
     @query_results = search_results.reload
    else
      @query_results = create_search_object(query)
    end
  end

  def create_search_object(query)
    object = Search.create(
      :term => query,
      :last_searched => DateTime.now
    )

    object.id ? object : not_found_error
  end

  def retrieve_search_object
    object = Search
      .includes(:search_instances)
      .where(:id => params[:id])
      .first

    object ? object : not_found_error
  end

  def not_found_error
    {
      :error => 'Either Binance does not pair your searched crypto-coin'\
        ' with USDT (Tether), or it does not exist.  Please check'\
        ' the spelling and try again.'
    }
  end
end
