# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search All Item API' do
  describe 'happy path' do
    before :each do
      @merchant = create(:merchant)
      @merchant2 = create(:merchant)
      @merchant3 = create(:merchant)
      @item = create(:item, merchant_id: @merchant.id, unit_price: 3.00, name: 'smashburger')
      @item2 = create(:item, merchant_id: @merchant.id, unit_price: 10.00, name: 'veggieburger')
      @item3 = create(:item, merchant_id: @merchant2.id, unit_price: 11.00, name: 'cheeseburger')
      @item4 = create(:item, merchant_id: @merchant2.id, unit_price: 8.00, name: 'burger')
      @item5 = create(:item, merchant_id: @merchant2.id, unit_price: 4.00, name: 'tiny burger')
      @item6 = create(:item, merchant_id: @merchant3.id, unit_price: 13.00, name: 'elk burger')
      @item7 = create(:item, merchant_id: @merchant3.id, unit_price: 100.00, name: 'no-bun burger')
    end

    it 'can find all items that match a search term' do
      get api_v1_items_find_all_path(name: 'burger')

      items_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(items_data[:data].count).to eq(7)
    end
    
    it 'returns items over min price param' do
      get '/api/v1/items/find_all?min_price=4.99'
      items_data = JSON.parse(response.body, symbolize_names: true)
  
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(items_data[:data].count).to eq(5)
      expect(items_data[:data][0][:attributes][:name]).to eq(@item2.name)
    end

    it 'returns items under max price param' do
      get '/api/v1/items/find_all?max_price=99.99'
      items_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(items_data[:data].count).to eq(6)
      expect(items_data[:data][5][:attributes][:name]).to eq(@item6.name)
    end

    it 'returns items between min and max price params' do
      get '/api/v1/items/find_all?min_price=4.99&max_price=99.99'

      items_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(items_data[:data].count).to eq(4)
      expect(items_data[:data][0][:attributes][:name]).to eq(@item2.name)
      expect(items_data[:data][3][:attributes][:name]).to eq(@item6.name)
      expect(items_data[:data][3][:attributes][:name]).to_not eq(@item7.name)
    end
  end
  
  describe 'sad path' do
    before :each do
      @merchant = create(:merchant)
      @merchant2 = create(:merchant)
      @merchant3 = create(:merchant)
      @item = create(:item, merchant_id: @merchant.id, unit_price: 10.00, name: 'smashburger')
      @item2 = create(:item, merchant_id: @merchant.id, unit_price: 10.00, name: 'veggieburger')
      @item3 = create(:item, merchant_id: @merchant2.id, unit_price: 11.00, name: 'cheeseburger')
      @item4 = create(:item, merchant_id: @merchant2.id, unit_price: 9.00, name: 'burger')
      @item5 = create(:item, merchant_id: @merchant2.id, unit_price: 6.00, name: 'tiny burger')
      @item6 = create(:item, merchant_id: @merchant3.id, unit_price: 13.00, name: 'elk burger')
      @item7 = create(:item, merchant_id: @merchant3.id, unit_price: 10.00, name: 'no-bun burger')
    end
    
    it 'returns 404 if invalid data is passed' do
      get api_v1_items_find_all_path(name: '')

      expect(response.status).to eq(404)
    end
  end
end
