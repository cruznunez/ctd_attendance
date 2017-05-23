ajaxSearch = ->
  # initialize local variable to hold timer and set defaults
  timer = null
  minLength = 2
  delay = 300

  # listen to when a user types into search field
  $('#search-form').on 'input', ->
    length = $('#q').val().length
    if length == 0 || length >= minLength
      data = $(@).serialize() # generate data from form

      clearTimeout timer # cancel timer if still running

      # set new timer. wait until the delay has passed before sending a request
      timer = setTimeout ->
        $.ajax url: location.pathname, type: 'POST', data: data
      , delay
autocomplete = ->
  select = (ui) ->
    # $('#semester_add_student').val ui.item.id
    # $('[for=autocomplete]').html "Add #{ui.item.label}"
    url = $('form').attr 'action'
    $.ajax url: url, type: 'PATCH', data: semester: add_student: ui.item.id
  $('#autocomplete').autocomplete
    minLength: 2
    source: '/students'
    select: (e, ui) -> select ui
datePicker = ->
  $('#date').datepicker dateFormat: 'yy-mm-dd', maxDate: 0

  $('#date').change ->
    Turbolinks.visit "#{window.location.pathname}?date=#{@.value}"

previewImage = ->
  $('#profile-img-file-field').change ->
    pix = @.files # array of images

    # functions
    setBackground = (url = '/plus.png') ->
      url = URL.createObjectURL pix[0] if pix.length
      $('#img-preview').css 'background-image', "url(#{url})"
      setTimeout (-> URL.revokeObjectURL url), 1000

    # execute this function
    setBackground()

previewReview = -> # rap god
  $('#comments,#notes').on 'input', ->
    $.ajax
      type: 'GET', url: '/preview_review'
      data: text: $(@).val(), id: $(@).attr 'id'

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

submitForm = -> $('#submit').click -> $('input[type=submit]').click()

updateInput = ->
  $('.field input').on 'input', ->
    $(@).attr 'value', if @.value == '' then null else ''

$(window).on 'turbolinks:load', ajaxSearch
$(window).on 'turbolinks:load', autocomplete
$(window).on 'turbolinks:load', datePicker
$(window).on 'turbolinks:load', resizeHandle
$(window).on 'turbolinks:load', previewImage
$(window).on 'turbolinks:load', previewReview
$(window).on 'turbolinks:load', submitForm
$(window).on 'turbolinks:load', updateInput
