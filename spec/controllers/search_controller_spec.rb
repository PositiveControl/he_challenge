require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe "GET index" do
    it "assigns @search_history" do
      search = Search.create(:term => "XRP")

      get :index

      expect(assigns(:search_history)).to eq([search])
    end
  end

  describe "GET index w/ search params" do
    it "assigns @search_history" do

      get :index, :params => { :query => "XRP" }

      expect(assigns(:query_results)).to be_present
    end
  end
end
