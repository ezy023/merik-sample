module ApplicationHelper

	# Returns the full title on a per-page basis.
	def full_title(page_title)
		base_title = "Muserik"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	# def show_user_bg
	# 	# Show user background
	# 	if signed_in?
	# 		if @user.background_image.blank?
	# 			"background:transparent url('/images/muserik_home_background.jpg') no-repeat fixed left top;"
	# 		else	
	# 			"background:transparent url(#{@user.background_image}) fixed left top;"
	# 		end
	# 	else
	# 		"background:transparent url('/images/muserik_home_background.jpg') no-repeat fixed left top;"
	# 	end
	# end


	# def google_analytics_js

	#     content_tag(:script, :type => 'text/javascript') do
	#       "var _gaq || [];
	#       _gaq.push(['_setAccount', 'XX-XXXXXXXX-X']);
	#       _gaq.push(['_trackPageview']);

	#       (function() {
	#         var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	#         ga.src = document.getElementByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	#       })();"
	#     end if Rails.env.production?
 # 	end
end
