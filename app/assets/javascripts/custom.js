$(document).ready(function () {
	// $('#what-is-hashtag').tooltip({
	// 	placement: 'right',
	// 	title: 'Track tweets and comments about this song through Twitter',

	// });


	$('#what-is-soundcloud').tooltip({
		placement: 'right',
		title: 'Post a link to a song (or playlist) on Soundcloud to share it with your followers',

	});

	$('.icon-play').hide()
	$(".song-link").hover(function(){
	  $(this).children('.icon-play').show();
	  },function(){
	  $(this).children('.icon-play').hide();
	});
});