class PurchaseItem < ApplicationRecord
  has_many :purchases
  monetize :price_cents

  def to_label
    "#{self.title} - #{self.price} #{self.price.currency.symbol}"
  end

  def is_first?
    self == PurchaseItem.first
  end
end