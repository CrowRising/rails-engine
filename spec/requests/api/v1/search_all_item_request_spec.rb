# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search All Item API' do
  describe 'happy path' do
    before :each do
      @merchant = create(:merchant)
      @merchant2 = create(:merchant)
      @merchant3 = create(:merchant)
      @item = create(:item, merchant_id: @merchant.id, unit_price: 10.00, name: 'smashburger')
      @item2 = create(:item, merchant_id: @merchant.id, unit_price: 10.00, name: 'veggieburger')
      @item3 = create(:item, merchant_id: @merchant2.id, unit_price: 11.00, name: 'cheeseburger')
      @item4 = create(:item, merchant_id: @merchant2.id, unit_price: 8.00, name: 'burger')
      @item5 = create(:item, merchant_id: @merchant2.id, unit_price: 7.00, name: 'tiny burger')
      @item6 = create(:item, merchant_id: @merchant3.id, unit_price: 13.00, name: 'elk burger')
      @item7 = create(:item, merchant_id: @merchant3.id, unit_price: 10.00, name: 'no-bun burger')
    end

    it 'can find all items that match a search term' do
      get api_v1_items_find_all_path(name: 'burger')

      items_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(items_data[:data].count).to eq(7)
    end
  end
end
