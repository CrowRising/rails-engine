require 'rails_helper'

RSpec.describe 'Item Merchant API' do
  describe 'happy path' do
    it 'can get the merchant for an item' do
      @merchant = create(:merchant)
      @merchant2 = create(:merchant)
      @merchant3 = create(:merchant)
      @item = create(:item, merchant: @merchant)

      get api_v1_item_merchant_index_path(@item)

      expect(response).to be_successful
    end
  end
end