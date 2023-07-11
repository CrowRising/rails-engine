require 'rails_helper'

RSpec.describe 'Items API' do
  describe 'happy path' do
    it 'sends a list of items' do
      id = create(:merchant).id
      id2 = create(:merchant).id
      create_list(:item, 3, merchant_id: id)
      create_list(:item, 3, merchant_id: id2)

      get api_v1_items_path

      item_data = JSON.parse(response.body, symbolize_names: true)  
      items = item_data[:data]

      expect(response).to be_successful

      items.each do |item|
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end

    it 'can get one item by its id' do
      merchant = create(:merchant)
      id = create(:item, merchant_id: create(:merchant).id).id

      get api_v1_item_path(id)

      item_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful

      expect(item_data[:data]).to have_key(:id)
      expect(item_data[:data][:id]).to eq(id.to_s)
      expect(item_data[:data][:attributes]).to have_key(:name)
      expect(item_data[:data][:attributes][:name]).to be_a(String)
      expect(item_data[:data][:attributes]).to have_key(:description)
      expect(item_data[:data][:attributes][:description]).to be_a(String)
      expect(item_data[:data][:attributes]).to have_key(:unit_price)
      expect(item_data[:data][:attributes][:unit_price]).to be_a(Float)  
      expect(item_data[:data][:attributes]).to have_key(:merchant_id)
      expect(item_data[:data][:attributes][:merchant_id]).to be_a(Integer)
    end
  end
end