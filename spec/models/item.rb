# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:merchant_id) }
  end

  describe 'class methods' do
    before :each do
      Item.destroy_all
      @item_1 = create(:item, name: 'Boots', unit_price: 110.00)
      @item_2 = create(:item, name: 'Hat', unit_price: 89.00)
      @item_3 = create(:item, name: 'Shirt', unit_price: 45.00)
      @item_4 = create(:item, name: 'Underwear', unit_price: 3.00)
    end

    it 'find_by_name_fragment' do
      expect(Item.find_by_name_fragment('oo')).to eq([@item_1])
      expect(Item.find_by_name_fragment('oo')).to_not eq([@item_2, @item_3, @item_4])
      expect(Item.find_by_name_fragment('Ha')).to eq([@item_2])
    end

    it 'find_by_price MIN' do
      result = Item.find_by_price(min_price: 100.00)
      expect(result).to eq([@item_1])
      expect(result).to_not eq([@item_2, @item_3, @item_4])
    end

    it 'find_by_price MAX' do
      result = Item.find_by_price(max_price: 100.00)
      expect(result).to eq([@item_2, @item_3, @item_4])
      expect(result).to_not eq([@item_1])
    end

    it 'find_by_price with range' do
      result = Item.find_by_price(min_price: 10.00, max_price: 100.00)
      expect(result).to eq([@item_2, @item_3])
      expect(result).to_not eq([@item_1, @item_4])
    end

    it 'find_all' do
      result = Item.find_all(name: 'oo')
      expect(result).to eq([@item_1])
    end

    it 'find_all with invalid params' do
      result = Item.find_all(name: '', min_price: nil, max_price: nil)
      expect(result).to eq(false)
    end

    it 'find_all with pricae range' do
      result = Item.find_all(min_price: 1.00, max_price: 50.00)
      expect(result).to eq([@item_3, @item_4])
      expect(result).to_not eq([@item_1, @item_2])
    end
  end
end
