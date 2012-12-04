$(document).ready(function () {
	// $("#soundcloud-upload-field").hide();
	// $("#micropost-form-fields").hide();

	$("#song-upload-form-title").click(function(){
		$("#micropost-form-fields").slideToggle()
	});

	$("#share-from-soundcloud").click(function(){
		$("#soundcloud-upload-field").slideToggle()
	});

});