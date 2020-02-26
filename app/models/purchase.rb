class Purchase < ApplicationRecord
  belongs_to   :user
  belongs_to   :purchase_item

  enum status: { pending: 0, failed: 1, paid: 2, paypal_executed: 3}
  enum payment_gateway: { paypal: 0 }

  validates :purchase_item_id, :user_id, :payment_gateway, presence: true

  after_save :add_title_to_purchase

  scope :recently_created, ->  { where(created_at: 1.minutes.ago..DateTime.now) }

  def set_paid
    self.status = Purchase.statuses[:paid]
  end

  def set_failed
    self.status = Purchase.statuses[:failed]
  end

  def set_paypal_executed
    self.status = Purchase.statuses[:paypal_executed]
  end

  protected

    def add_title_to_purchase
      self.update(title: self.purchase_item.to_label)
    end
end