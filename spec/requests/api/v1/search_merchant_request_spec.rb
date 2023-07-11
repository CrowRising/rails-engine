require 'rails_helper'

RSpec.describe 'Search Merchant API' do
  describe 'happy path' do
    it 'can return single merchant if matched' do
      @merchant = create(:merchant, name: "Bob Burgers")
      get api_v1_merchants_find_path(name: 'Bob Burgers')
      
      expect(response).to be_successful
      
      merchant_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(merchant_data[:data][:attributes]).to have_key(:name)
      expect(merchant_data[:data][:attributes][:name]). to be_a String
      expect(merchant_data[:data][:attributes][:name]).to eq(@merchant.name)
      expect(merchant_data[:data][:attributes][:name]).to_not eq("Bobby Burgers")
    end
    
    it 'can return single merchant if matched case insensitive' do
      create(:merchant, name: "Bob Burgers")
      create(:merchant, name: "Cat Burgers")
      create(:merchant, name: "Dog Burgers")
      get api_v1_merchants_find_path(name: 'Burg')
      
      merchant_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      
      expect(merchant_data[:data][:attributes]).to have_key(:name)
      expect(merchant_data[:data][:attributes][:name]). to be_a String  
      expect(merchant_data[:data][:attributes][:name]).to eq("Bob Burgers")
      expect(merchant_data[:data][:attributes][:name]).to_not eq("Cat Burgers")
    end
  end
  
  describe 'sad path' do
    it 'returns 404 if no data is passed' do
  
      get api_v1_merchants_find_path(name: '')

     expect(response.status).to eq(404)
     error = JSON.parse(response.body, symbolize_names: true)
     expect(error).to have_key(:error)
     expect(error[:error]).to eq("Bad Request")
    end

    it 'returns not found when no match' do
      @merchant = create(:merchant, name: "Bob Burgers")

      get api_v1_merchants_find_path(name: 'kasjdfk')

      merchant_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(merchant_data[:data]).to eq([])
    end
  end
end