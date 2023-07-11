# frozen_string_literal: true

class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name

  def self.find_by_name_fragment(fragment)
    Merchant.where('name ILIKE ?', "%#{fragment}%").order(:name)
  end
end
