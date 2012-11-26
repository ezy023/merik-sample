$(window).scroll ->
    # Bail out right away if we're busy loading the next chunk.
    return if(window.pagination_loading)

    url = $('.pagination .next_page a').attr('href')
    if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 50
        # Make a note that we're busy loading the next chunk.
        window.pagination_loading = true

        # Load as before but attach a callback to clear the flag when we're done.
        $.getScript(url).always -> window.pagination_loading = false