class Ducats
  constructor: () ->
    @$purchase_form = $('#new_purchase')
    @innitialize_listeners()
    @innitialize_paypal()

  innitialize_listeners: () ->
    # to add listners

  innitialize_paypal: () ->
    @setupPaypal() if @$purchase_form.exists()

  setupPaypal: () ->
    paypal.Buttons(
      env: 'sandbox'
      createOrder: () ->
        $.post('/ducats/create_payment').then (data) ->
          data.token
      onApprove: (data) =>
        $.post('/ducats/execute_payment',
          paymentID: data.paymentID
          payerID: data.payerID).then =>
            @submitOrderPaypal(data.paymentID)
        return
    ).render('#submit-paypal')

  isPayment: () ->
    return $('[data-charges-and-payments-section] input[name="orders[product_id]"]:checked').length

  submitOrderPaypal: (chargeID) =>
    # Add a hidden input purchase[charge_id]
    @$purchase_form.append($('<input type="hidden" name="purchase[charge_id]"/>').val(chargeID))
    # Set order type
    @$purchase_form.submit()

$(document).ready ->
  ducats = new Ducats
