(($) ->
  $.fn.placeholder = (options) ->
    this.each ->
      $this = $(this)
      placeholder = $this.attr('placeholder')
      clearOnFocus = (options && options['clearOnFocus']) || false

      # If we find a placeholder attribute on the element
      if !!placeholder
        # Remove the placeholder attribute
        $this.removeAttr('placeholder')

        # Create and wrap the input in the input-holder
        inputHolder = $this.wrap($(document.createElement('span')).addClass('input-holder')).parent()

        # Create the span that holds the default value
        inputDefault = $(document.createElement('span')).text(placeholder).addClass('input-default')
        inputHolder.prepend(inputDefault)

        # Pass clicks on the placeholder text through to the input
        inputDefault.click -> $this.focus()

        if clearOnFocus
          $this.focus -> inputDefault.hide()
          $this.blur -> inputDefault.show() unless !!$this.val().length
        else
          $this.keydown (event)->
            if (event.keyCode != '8' && event.keyCode != '9' && event.keyCode != '16')
              inputDefault.hide()

          $this.keyup -> inputDefault.show() unless !!$this.val().length

          $this.change ->
            inputDefault.toggle(!!!$this.val())
          .trigger('change')

) jQuery
