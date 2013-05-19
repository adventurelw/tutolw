# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("#micropost_content").keyup ->
    input_len = $("#micropost_content").val().length
    $("#content_count").text(140 - input_len)

