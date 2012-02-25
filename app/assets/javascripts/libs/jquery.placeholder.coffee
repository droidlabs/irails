#
# jQuery Placeholder Plugin
# https://github.com/droidlabs/jquery.placeholder
# Copyright (c) 2011-2012 Droid Labs
# Licenced under [MIT](http://www.opensource.org/licenses/mit-license.php).
#
(($) ->
  $.fn.placeholder = (options) ->
    defaults =
      color: "#777"
      colorFocus: "#bbb"

    options = jQuery.extend(defaults, options)
    $(this).each ->
      if $(this).data("placeholder-enabled")
        return false
      else
        $(this).data "placeholder-enabled", true
      
      # create helper
      $field = $(this)
      $cover = $("<div class=\"_placeholder\">" + $(this).attr("placeholder") + "</div>")
      $cover.insertAfter $field
      $cover.css(
        cursor: "text"
        position: "absolute"
        top: $field.offset().top
        left: $field.offset().left
        color: (if $(this).is(":focus") then options.colorFocus else options.color)
        "padding-left": $field.css("padding-left")
        "padding-right": $field.css("padding-right")
        "padding-top": $field.css("padding-top")
        "padding-bottom": $field.css("padding-bottom")
        "line-height": $field.css("line-height")
        "font-size": $field.css("font-size")
        "margin-left": "3px"
        "margin-top": $field.css("margin-top")
      ).on "click", ->
        $field.focus()
      
      # bind events
      $field.on("keydown keypress keyup blur change", ->
        if $(this).val().length then $cover.hide() else $cover.fadeIn(100)
      ).on("focus", ->
        $cover.css("color", options.colorFocus)
      ).on("blur", ->
        $cover.css("color", options.color)
      ).attr("placeholder", "").change()
      $(window).on "resize", ->
        $cover.css
          top: $field.offset().top
          left: $field.offset().left
) jQuery