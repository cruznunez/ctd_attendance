datePicker = ->
  $('#date').datepicker dateFormat: 'yy-mm-dd', maxDate: 0

  $('#date').change ->
    Turbolinks.visit "#{window.location.pathname}?date=#{@.value}"

resizeHandle = ->
  drag = (handle) ->
    height = $(handle).position().top
    textarea = $(handle).prev('textarea')
    textarea.outerHeight height + 6
  if $('textarea').length
    top = $('textarea').offset().top + 20
    $('.resize-handle').draggable
      axis: 'y',
      containment: [0, top, 0, top + 500], # [x1, y1, x2, y2]
      drag: -> drag @,
      stop: -> drag @

submitForm = -> $('#submit').click -> $('form').submit()

updateInput = ->
  $('.field input').on 'input', ->
    $(@).attr 'value', if @.value == '' then null else ''

$(window).on 'turbolinks:load', datePicker
$(window).on 'turbolinks:load', resizeHandle
$(window).on 'turbolinks:load', submitForm
$(window).on 'turbolinks:load', updateInput
