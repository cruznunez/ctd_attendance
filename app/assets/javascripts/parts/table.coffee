@trClick = ->
  $('tr[href]').on 'click', (e) ->
    path = $(@).attr 'href'
    if e.metaKey # if user is pressing the command key
      open path # simulate open in new tab
    else
      Turbolinks.visit path # simulate a regular click

$(window).on 'turbolinks:load', trClick
