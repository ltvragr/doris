# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$('#project_lab_tokens').tokenInput '/labs.json'
		theme: 'facebook'
		prePopulate: $('#project_lab_tokens').data('load')
jQuery ->        
    $('#project_user_tokens').tokenInput '/users.json'
        theme: 'facebook'
        prePopulate: $('#project_user_tokens').data('load')
        propertyToSearch: "login"