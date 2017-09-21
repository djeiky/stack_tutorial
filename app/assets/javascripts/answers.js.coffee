editanswer = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show()

$(document).ready(editanswer)
$(document).on('turbolinks:load', editanswer)
