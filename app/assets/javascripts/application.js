// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap
//= require bootstrap_custom
//= require jquery.tokeninput
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require jquery.isotope.min
//= require info_fields
//= require labs
//= require projects
//= require public
//= require users
//= require home

$('.datatable').dataTable({
  "sDom": "<'row'<'span7'l><'span5'f>r>t<'row'<'span7'i><'span5'p>>",
  "sPaginationType": "bootstrap"
});

$("#logo-search-field").popover({
  trigger: 'focus'
});

$(".favorite").tooltip({
  placement: 'left'
});

$(document).ready(function() {
  // Stuff to do as soon as the DOM is ready;
  $('.isotope-container').isotope({
    itemSelector : '.isotope-box',
    layoutMode : 'fitRows'
  });

});

