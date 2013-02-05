$(document).ready(function(){
  var count = $('.slider_parent .block').length;
  $('.slider_parent').css('width', count*385);
});


$('.block').hover(function() {
  $(this).addClass('highlight');
  $(this).find(".hover_only").removeClass('hidden');
}, function() {
  $(this).removeClass('highlight');
  $(this).find(".hover_only").addClass('hidden');
});

$('.to_button').hover(function() {
  $(this).addClass('button_highlight');
}, function() {
  $(this).removeClass('button_highlight');
});

$(".to_left").click(function() {
  var offset = parseInt($('.slider_parent').css('margin-left'));
  console.log(offset)
  if (offset < -100) {
    $('.slider_parent').animate({
      marginLeft: '+=375',
    }, 500);
  }
});

$(".to_right").click(function() {
  var offset = parseInt($('.slider_parent').css('margin-left'));
  var width = parseInt($('.slider_parent').css('width')) * -1;
  console.log(offset, width)
  if (offset > width + 1300) {
    $('.slider_parent').animate({
      marginLeft: '-=375',
    }, 500);
  }
});