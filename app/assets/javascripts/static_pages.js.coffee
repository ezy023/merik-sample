$(window).scroll ->
    return if(window.pagination_loading)

    url = $('.pagination .next_page a').attr('href')
    if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 50
        window.pagination_loading = true

        $('.pagination').text('Fetching more products...')
        $.getScript(url).always -> window.pagination_loading = false