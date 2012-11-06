class MicropostsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :correct_user, only: :destroy
	
	def index
		@microposts = Micropost.paginate(page: params[:page]).search(params[:search])
	end
	
	def show
		@micropost = Micropost.find_by_id(params[:id])
	end

	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end
	
	def destroy
		@micropost.destroy
		redirect_to root_url
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
	

	
	
	private
		
		def correct_user
			@micropost = current_user.microposts.find_by_id(params[:id])
			redirect_to root_url if @micropost.nil?
		end
end