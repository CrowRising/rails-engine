# frozen_string_literal: true

class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name

  def self.find_by_name_fragment(fragment)
    Merchant.where('name ILIKE ?', "%#{fragment}%").order(:name)
  end

  def self.find_by_all_merch_id(merch_id)
    Merchant.find(merch_id).items
  end
end
