require 'rails_helper'

RSpec.describe 'Search Merchant API' do
  describe 'happy path' do
    before :each do 
      @merchant = create(:merchant, name: "Bob Burgers")
    end

    it 'can return single merchant if matched' do
      get api_v1_merchants_find_path(name: 'Bob Burgers')

      expect(response).to be_successful

      merchant_data = JSON.parse(response.body, symbolize_names: true)

      expect(merchant_data[:data][:attributes]).to have_key(:name)
      expect(merchant_data[:data][:attributes][:name]). to be_a String
      expect(merchant_data[:data][:attributes][:name]).to eq(@merchant.name)
      expect(merchant_data[:data][:attributes][:name]).to_not eq("Bobby Burgers")
    end
  end
end