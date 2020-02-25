class Ducats
  constructor: () ->
    @$payment_details = $('#payment-details')
    @innitialize_listeners()
    @innitialize_paypal()

  innitialize_listeners: () ->
    $(document).on 'change', '#payment-selection_paypal', (e) =>
      newActiveTabID = $('input[name="payment-selection"]:checked').val();
      $('.paymentSelectionTab').removeClass('active');
      $('#tab-' + newActiveTabID).addClass('active');


  innitialize_paypal: () ->
    @setupPaypal() if @$payment_details.exists()

  setupPaypal: () ->
    paypal.Buttons(
      env: 'sandbox'
      createOrder: () ->
        $.post('/ducats/create_payment').then (data) ->
          data.token
      onApprove: (data) =>
        $.post('/ducats/execute_payment',
          paymentID: data.paymentID
          payerID: data.payerID).then ->
            console.log 'inside on approve'
            # @submitOrderPaypal(data.paymentID)
        return
    ).render('#submit-paypal')

    isPayment: () ->
      return $('[data-charges-and-payments-section] input[name="orders[product_id]"]:checked').length

    submitOrderPaypal: (chargeID) ->
      $form = $("#order-details")
      # Add a hidden input orders[charge_id]
      $form.append($('<input type="hidden" name="orders[charge_id]"/>').val(chargeID))
      # Set order type
      $('#order-type').val('paypal')
      $form.submit()

$(document).ready ->
  ducats = new Ducats
