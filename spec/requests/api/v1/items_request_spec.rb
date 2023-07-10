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
    end
  end
end