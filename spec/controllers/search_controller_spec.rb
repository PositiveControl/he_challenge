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

  describe "GET show" do
    it "returns a search object" do
      search = Search.create(:term => "XRP")

      get :show, :params => { :id => search.id }

      expect(assigns(:search)).to eq(search)
    end

    context "not found" do
      it "returns error message" do
        get :show, :params => { :id => 0 }

        expect(assigns(:search)[:error]).to be_present
      end
    end
  end
end
