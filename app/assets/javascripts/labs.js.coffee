# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#lab_user_tokens').tokenInput '/users.json?source=lab',
    theme: 'facebook'
    prePopulate: $('#lab_user_tokens').data('load')
    propertyToSearch: "login"
    preventDuplicates: true
    tokenLimit: 1
    allowTabOut: true
    tokenValue = "name"
    resultsFormatter: (user) ->
      "<li>" + user.first_name + " " + user.last_name + " (" + user.login + ")</li>"
    tokenFormatter: (user) ->
      "<li>" + user.first_name + " " + user.last_name + " (" + user.login + ")</li>"