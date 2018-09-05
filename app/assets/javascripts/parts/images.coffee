imgExpand = -> $('#profile-img').click -> $(@).toggleClass('big')

$(window).on 'turbolinks:load', imgExpand
