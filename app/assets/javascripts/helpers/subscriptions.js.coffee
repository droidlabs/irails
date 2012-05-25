$ ->
  $form = $('form#new_card')
  $cardNumber = $form.find('input#card_number')
  $cardExpiryYear = $form.find('#card_expires_at_1i')
  $cardExpiryMonth = $form.find('#card_expires_at_2i')

  getCardType = ->
    $form.find('input#card_card_type').val Stripe.cardType($cardNumber.val())

  validateCardNumber = ->
    setInputError($cardNumber, 'is invalid') unless Stripe.validateCardNumber($cardNumber.val())

  validateExpiry = ->
    setInputError($cardExpiryMonth, 'is invalid') unless Stripe.validateExpiry($cardExpiryMonth.val(), $cardExpiryYear.val())

  setInputError = ($input, message)->
    $input.closest('form').data('valid', false)
    $input.after($('<span/>', class: 'error').html(message)).closest('.input').addClass('field_with_errors')

  clearErrors = ($input = null)->
    $form.data('valid', true)
    $inputs = if $input then $input.closest('.input') else $form.find('.input')
    $inputs.removeClass('field_with_errors').find('span.error').remove()

  freePlan = ->
    $('#card_plan').val() == 'free'

  if !!$form.length
    $('#card_plan').change ->
      $('.card-fields').toggle !freePlan()
    .trigger('change')

    $('#change_card_details').click ->
      $(this).closest('.about-card').hide().siblings('.card-form').show()
      false

    $form.submit ->
      return true# if freePlan()
      clearErrors()
      validateCardNumber()
      validateExpiry()
      $form.data('valid')

    $cardNumber.keyup ->
      clearErrors($cardNumber)
      getCardType()
      validateCardNumber()

    $cardExpiryMonth.add($cardExpiryYear).change ->
      clearErrors($cardExpiryMonth)
      validateExpiry()
    .trigger('change')
