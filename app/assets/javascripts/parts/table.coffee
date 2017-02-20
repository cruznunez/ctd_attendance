@trClick = -> $('tr[href]').click -> Turbolinks.visit $(@).attr 'href'

$(window).on 'turbolinks:load', trClick
