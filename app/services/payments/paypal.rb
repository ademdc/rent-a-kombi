class Payments::Paypal
  # def self.finish(charge_id)
  #   order = Order.paypal_executed.recently_created.find_by(charge_id: charge_id)
  #   return nil if order.nil?
  #   order.set_paid
  #   order
  # end

  def self.create_payment
    payment_price = 10
    currency = "EUR"
    payment = PayPal::SDK::REST::Payment.new({
      intent:  "sale",
      payer:  {
        payment_method: "paypal" },
      redirect_urls: {
        return_url: "/",
        cancel_url: "/" },
      transactions:  [{
        item_list: {
          items: [{
            name: '100 tokens',
            sku: '1st sku',
            price: payment_price,
            currency: currency,
            quantity: 1 }
            ]
          },
        amount:  {
          total: payment_price,
          currency: currency
        },
        description:  "Payment for: 100 tokens"
      }]
    })
    return payment.token if payment.create
  end

  def self.execute_payment(payment_id:, payer_id:, current_user_id:)
    user = User.find(current_user_id)
    payment = PayPal::SDK::REST::Payment.find(payment_id)
    if payment.execute( payer_id: payer_id )
      return user.add_ducats(100)
    end
  end
end