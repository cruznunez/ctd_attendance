standUpDatePicker = ->
  $('#stand_up_date').datepicker dateFormat: 'yy-mm-dd', maxDate: 0

  $('#stand_up_date').change ->
    path = window.location.pathname.match(/\/projects.+stand_ups/)
    Turbolinks.visit "#{path}/new?date=#{@.value}"

$(window).on 'turbolinks:load', standUpDatePicker
