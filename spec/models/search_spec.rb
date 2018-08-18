require 'rails_helper'

RSpec.describe Search, type: :model do
  context "#create" do
    it "does not create search when :term not provided" do
      new_search = Search.create(:term => nil)
      expect(new_search.id).to eq(nil)
    end

    it "does not create search when :term exists" do
      5.times { Search.create(:term => "ETH") }
      expect(Search.all.count).to eq(1)
    end

    it "does not create invalid searches" do
      new_search = Search.create(:term => "NOTREALCOIN")
      binding.pry
      expect(new_search.id).to eq(nil)
    end

    it "creates search objects when term is unique" do
      ["BNB","XRP","ETH","BTC","LTC"].each do |ticker|
        Search.create(:term => ticker)
      end

      expect(Search.all.count).to eq(5)
    end

    it "sets times searched to 1 when created" do
      new_search = Search.create(:term => "LTC")
      expect(new_search.times_searched).to eq(1)
    end
  end
end
