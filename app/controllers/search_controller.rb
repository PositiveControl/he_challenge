class SearchController < ApplicationController
  before_action :retrieve_query, :only => [:index]

  def index
    @search_history = last_ten_searches

    if params[:query]
      @query
    end
  end

  def show

  end

  private

  def last_ten_searches
    @last_ten_searches =
      Search.order(:updated_at).take(10)
  end

  def retrieve_query
    @query =
      Search.find_or_create_by(:term => params[:query])
  end
end
