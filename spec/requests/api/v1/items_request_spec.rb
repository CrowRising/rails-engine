# frozen_string_literal: true

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
      create(:merchant)
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

    it 'can create a new item' do
      item_params = {
        name: 'Saw',
        description: 'Making it easier to saw things in half',
        unit_price: 15.99,
        merchant_id: create(:merchant).id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }  

      post api_v1_items_path, headers: headers, params: JSON.generate(item_params)
      created_item = Item.last

      expect(response).to be_successful
      expect(created_item.name).to eq('Saw')
      expect(created_item.description).to eq('Making it easier to saw things in half')
      expect(created_item.unit_price).to eq(15.99)
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])
    end

    it 'can update an existing item' do 
      @merchant = create(:merchant)
      @merchant2 = create(:merchant)
      id = create(:item, merchant_id: @merchant.id).id

      edit_item_params = { 
        name: 'Hammer', 
        description: 'Making it easier to hammer things in', 
        unit_price: 12.99,
        merchant_id: @merchant2.id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch api_v1_item_path(id), headers: headers, params: JSON.generate(edit_item_params)
      edited_item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(edited_item.name).to eq('Hammer')
      expect(edited_item.name).to_not eq('Saw')
      expect(edited_item.description).to eq('Making it easier to hammer things in')
      expect(edited_item.description).to_not eq('Making it easier to saw things in half')
      expect(edited_item.unit_price).to eq(12.99)
      expect(edited_item.unit_price).to_not eq(15.99)
      expect(edited_item.merchant_id).to eq(@merchant2.id)
      expect(edited_item.merchant_id).to_not eq(@merchant.id)
    end

    it 'can destroy an item' do
      create(:merchant)
      id = create(:item, merchant_id: create(:merchant).id).id

      expect(Item.count).to eq(1)
    end
  end
end