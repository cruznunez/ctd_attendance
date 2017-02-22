enableAttendance = ->
  $('label[disabled]').click ->
    id_partial = $(@).attr('for').slice 0, -7
    $("[id^=#{id_partial}]").removeAttr 'disabled'

$(window).on 'turbolinks:load', enableAttendance
