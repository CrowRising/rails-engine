class MerchantItemsFacade
  def self.find_by_all_merch_id(merch_id)
    Merchant.find(merch_id).items
  end
end