$(document).ready(function () {
	$('#what-is-hashtag').tooltip({
		placement: 'right',
		title: 'Track tweets and comments about this song through Twitter',

	});
	$('.icon-play').hide()
	$(".song-link").hover(function(){
	  $(this).children('.icon-play').show();
	  },function(){
	  $(this).children('.icon-play').hide();
	});
});