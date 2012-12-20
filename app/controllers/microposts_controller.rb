class MicropostsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :correct_user, only: :destroy
	respond_to :html, :json
	
	def index
		@microposts = Micropost.by_top.paginate(page: params[:page]).search(params[:search])
	end	

	def show
		@micropost = Micropost.find(params[:id])
	end

	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_url
		else
			@feed_items = current_user.feed
			render 'static_pages/home'
		end
	end
	
	def destroy
		@micropost.destroy
		redirect_to root_url
	end

	def update
		@micropost = Micropost.find(params[:id])
		@micropost.update_attributes(params[:micropost])
		respond_with @micropost
	end

	# def retweet
 #    @original_micropost = Micropost.find_by_id(params[:id])
 #    if @original_micropost
 #      @new_micropost = current_user.microposts.build(user_id: @original_micropost.user_id, title: @original_micropost.title, song:@original_micropost.song, artist:@original_micropost.artist, genre:@original_micropost.genre, available:@original_micropost.available)
 #        if @new_micropost.save
 #          redirect_to user_path(current_user)
 #          flash[:success] = "Retweet Successful"
 #        else
 #          redirect_to user_path(current_user), notice:
 #          @new_micropost.errors.full_messages
 #        end
 #    else
 #      redirect_back_or current_user
 #      flash[:error] = "Retweet error!"
 #    end
 #  end

	 def soundcloud_song
				@link = params[:sc_link]
				@client_id = ENV['SOUNDCLOUD_CLIENT_ID']
				client = Soundcloud.new(:client_id => @client_id)
				track = client.get('/resolve', :url => @link)
				if track.tracks?
					track.tracks.each do |t|
						stream_url = "#{t.stream_url}?client_id=#{@client_id}"
						@post = current_user.microposts.build(user_id: current_user.id, title: t.title, artist: t.user.username, genre: t.genre, sc_link: stream_url)
						if @post.save
							puts "Got #{t.title}"
						else
							puts "Not working"
						end
					end
					redirect_to root_url
				else
					stream_url = "#{track.stream_url}?client_id=#{@client_id}"
					@post = current_user.microposts.build(user_id: current_user.id, title: track.title, artist: track.user.username, genre: track.genre, sc_link: stream_url)
					if @post.save
						flash[:success] = "Got it!"
						redirect_to root_url
					else
						flash[:error] = "No go bro"
						redirect_to root_url
					end
				end

		end
	
	def vote_up
		comment = Micropost.find(params[:id])
		comment.vote :voter => current_user
		redirect_to :back
	end

	def vote_down
		comment = Micropost.find(params[:id])
		comment.vote :voter => current_user, :vote => 'bad'
		redirect_to :back
	end

	
	
	private
		
		def correct_user
			@micropost = current_user.microposts.find_by_id(params[:id])
			redirect_to root_url if @micropost.nil?
		end
end