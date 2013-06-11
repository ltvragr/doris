# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#project_lab_tokens').tokenInput '/labs.json',
    theme: 'facebook'
    prePopulate: $('#project_lab_tokens').data('load')
    preventDuplicates: true
    noResultsText: "Your lab is not listed. Make a new lab <a href='../labs/new'> here </a>"
    allowTabOut: true
  $('#project_user_tokens').tokenInput '/users.json?source=project',
    theme: 'facebook'
    prePopulate: $('#project_user_tokens').data('load')
    propertyToSearch: "login"
    preventDuplicates: true
    allowTabOut: true
    resultsFormatter: (user) -> 
      "<li>" + user.first_name + " " + user.last_name + " (" + user.login + ")</li>"
    tokenFormatter: (user) -> 
      "<li>" + user.first_name + " " + user.last_name + " (" + user.login + ")</li>"
  $('#project_tag_tokens').tokenInput '/tags.json',
    theme: 'facebook'
    prePopulate: $('#project_tag_tokens').data('load')
    resultsLimit: 10
    preventDuplicates: true
    propertyToSearch: "name"
    tokenValue: "name"
    allowTabOut: true
    resultsFormatter: (tag) ->
      if tag.id == null
        "<li>" + tag.name + " (creating a new tag)</li>"
      else
        "<li>" + tag.name + "</li>"