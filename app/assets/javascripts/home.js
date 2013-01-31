$(document).ready(function(){
  var count = $('.slider_parent .block').length;
  $('.slider_parent').css('width', count*385);
});


$('.block').hover(function() {
  $(this).addClass('highlight');
}, function() {
  $(this).removeClass('highlight');
});

$('.to_button').hover(function() {
  $(this).addClass('button_highlight');
}, function() {
  $(this).removeClass('button_highlight');
});

$(".to_left").click(function() {
  var offset = parseInt($('.slider_parent').css('margin-left'));
  if (offset < -100) {
    $('.slider_parent').animate({
      marginLeft: '+=375',
    }, 500);
  }
});

$(".to_right").click(function() {
  var offset = parseInt($('.slider_parent').css('margin-left'));
  var width = parseInt($('.slider_parent').css('width')) * -1;
  if (offset > width + 1300) {
    $('.slider_parent').animate({
      marginLeft: '-=375',
    }, 500);
  }
});