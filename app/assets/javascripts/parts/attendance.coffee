enableAttendance = ->
  $('label[disabled]').click ->
    id_partial = $(@).attr('for').slice 0, -7
    $("[id^=#{id_partial}]").removeAttr 'disabled'

deleteDay = ->
  links = $ '[data-toggle=popover]'
  links.popover placement: 'top', html: true
  links.on 'show.bs.popover', -> links.popover 'hide'

$(window).on 'turbolinks:load', deleteDay
$(window).on 'turbolinks:load', enableAttendance
