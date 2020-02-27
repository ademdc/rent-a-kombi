class Purchase < ApplicationRecord
  belongs_to   :user
  belongs_to   :purchase_item

  enum status: [:pending, :failed, :paid, :paypal_executed]
  enum payment_gateway: [:paypal]

  validates :purchase_item_id, :user_id, :payment_gateway, presence: true

  scope :recently_created, ->  { where(created_at: 1.minutes.ago..DateTime.now) }
  scope :for_user, -> (user) { where(user_id: user.id) }

  def set_paid
    self.paid!
  end

  def set_failed
    self.failed!
  end

  def set_paypal_executed
    self.paypal_executed!
  end

  def set_title
    return unless self.purchase_item.present?

    self.title = self.purchase_item.to_label
  end
end