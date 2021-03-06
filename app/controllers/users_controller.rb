class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  
  def show
  	@user = User.find(params[:id])
    @microposts = Micropost.show_user_posts(@user).paginate(page: params[:page], page: params[:page]).per_page(20)
  end
  
  def new
  	@user = User.new 	
  end
  
  def index
  	# @users = User.search(params[:search])
  	@users = User.paginate(page: params[:page]).search(params[:search])
  	#@search_users = User.search(params[:search])
  end
  
  def create
  	@user = User.new(params[:user])
  	if @user.save
  		sign_in @user
  		flash[:success] = "Welcome to the Muzerik Beta! We are still a work in progress and love feedback. Please let us know how we can improve. Enjoy!"
  		redirect_to root_path
  	else
  		render 'new'
  	end  	
  end
  
  def edit
  end
  
  def destroy
  	User.find(params[:id]).destroy
  	flash[:success] = "User destroyed"
  	redirect_to users_url
  	# unless current_user.admin?	Prevent admin from destroying themselves possible solution
  end
  
  
  def update
  	if @user.update_attributes(params[:user])
  		flash[:success] = "Profile updated"
  		sign_in @user
  		redirect_to @user  	
  	else
  		render 'edit'
  	end
  end
  
  def following
  	if signed_in?
  		@title = "Following"
  		@user = User.find(params[:id])
  		@users = @user.followed_users.paginate(page: params[:page])
  		render 'show_follow'
  	else
  		redirect_to signin_path
  	end
  end
  
  def followers
  	if signed_in?
  		@title = "Followers"
  		@user = User.find(params[:id])
  		@users = @user.followers.paginate(page: params[:page])
  		render 'show_follow'
  	else
  		redirect_to signin_path
  	end  
  end
  
  private
  	
  	def correct_user	
  		@user = User.find(params[:id])
  		redirect_to(root_path) unless current_user?(@user)
  	end
  	
  	def admin_user
  		redirect_to(root_path) unless current_user.admin?
  	end
  
end
