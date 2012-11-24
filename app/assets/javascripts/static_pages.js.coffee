jQuery ->
	if $('.pagination').length
		$(window).scroll ->
			url = $('.pagination .next_page').attr('href')
			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 20
				$('.pagination').text("Fetching")
				$.getScript(url)
			$(window).scroll()