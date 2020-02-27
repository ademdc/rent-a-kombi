class Payments::Paypal
  def self.finish(charge_id)
    purchase = Purchase.paypal_executed.recently_created.find_by(charge_id: charge_id)
    return nil if purchase.nil?

    purchase.set_paid
    purchase.set_title
    purchase.save
  end

  def self.create_payment(purchase:)
    payment_price = purchase.purchase_item.price.amount.to_i
    currency = 'USD'

    payment = PayPal::SDK::REST::Payment.new({
      intent:  :sale,
      payer:  {
        payment_method: Payments::PaymentGateways::PAYPAL },
      redirect_urls: {
        return_url: "/",
        cancel_url: "/" },
      transactions:  [{
        item_list: {
          items: [{
            name: purchase.purchase_item.to_label,
            price: payment_price,
            currency: currency,
            quantity: 1 }
            ]
          },
        amount:  {
          total: payment_price,
          currency: currency
        },
        description: purchase.purchase_item.to_label
      }]
    })
    if payment.create
      purchase.token = payment.token
      purchase.charge_id = payment.id
      return payment.token if purchase.save
    end
  end

  def self.execute_payment(payment_id:, payer_id:, current_user_id:)
    user = User.find(current_user_id)
    purchase = Purchase.recently_created.find_by(charge_id: payment_id)
    purchase_amount = purchase.purchase_item.price.amount.to_i

    return false unless purchase && purchase_amount

    payment = PayPal::SDK::REST::Payment.find(payment_id)

    if payment.execute(payer_id: payer_id)
      purchase.set_paypal_executed
      purchase.save
      return user.add_ducats(purchase_amount)
    end
  end
end