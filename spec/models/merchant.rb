# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    before :each do
      Merchant.destroy_all
      @merchant_1 = create(:merchant, name: 'Boots and Stuff')
      @merchant_2 = create(:merchant, name: 'Hats and Things')
      @merchant_3 = create(:merchant, name: 'Shirts and More Too')
      @merchant_4 = create(:merchant, name: 'Underpinnings Galore')
    end

    it 'find_by_name_fragment' do
      expect(Merchant.find_by_name_fragment('and')).to eq([@merchant_1, @merchant_2, @merchant_3])
      expect(Merchant.find_by_name_fragment('and')).to_not eq([@merchant_4])
      expect(Merchant.find_by_name_fragment('Gal')).to eq([@merchant_4])
    end

    it 'find_by_all_merch_id' do
      expect(Merchant.find_by_all_merch_id(@merchant_1.id)).to eq(@merchant_1.items)
      expect(Merchant.find_by_all_merch_id(@merchant_2.id)).to eq(@merchant_2.items)
      expect(Merchant.find_by_all_merch_id(@merchant_3.id)).to eq(@merchant_3.items)
      expect(Merchant.find_by_all_merch_id(@merchant_4.id)).to eq(@merchant_4.items)
    end
  end
end
