class Ducats
  constructor: () ->
    @$purchase_form = $('#new_purchase')
    @$loader = $('.ui-page-loader')
    @innitialize_listeners()
    @innitialize_paypal()

  innitialize_listeners: () ->
    # to add listners

  innitialize_paypal: () ->
    @setupPaypal() if @$purchase_form.exists()

  setupPaypal: () ->
    paypal.Buttons(
      env: 'sandbox'
      createOrder: () =>
        $.post('/purchases/create_paypal_payment', @$purchase_form.serialize()).then (data) ->
          data.token
      onApprove: (data) =>
        @$loader.show()
        $.post('/purchases/execute_paypal_payment',
          paymentID: data.paymentID
          payerID: data.payerID).then =>
            @submitOrderPaypal(data.paymentID)
        return
    ).render('#submit-paypal')

  isPayment: () ->
    return $('[data-charges-and-payments-section] input[name="orders[product_id]"]:checked').length

  submitOrderPaypal: (chargeID) =>
    @$purchase_form.append($('<input type="hidden" name="purchase[charge_id]"/>').val(chargeID))
    @$purchase_form.submit()

$(document).ready ->
  ducats = new Ducats
