class Ducats
  constructor: () ->
    @innitialize_listeners()
    @innitialize_paypal()

  innitialize_listeners: () ->
    $(document).on 'change', '#payment-selection_paypal', (e) =>
      newActiveTabID = $('input[name="payment-selection"]:checked').val();
      $('.paymentSelectionTab').removeClass('active');
      $('#tab-' + newActiveTabID).addClass('active');


  innitialize_paypal: () ->
    @setupPaypal()

  setupPaypal: () ->
    paypal.Buttons(
      # env: "sandbox",
      # createOrder: () ->
      # onApprove: (data) ->
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
