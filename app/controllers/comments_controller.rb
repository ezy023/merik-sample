class CommentsController < ApplicationController

	def create
		commentable = Micropost.find(params[:micropost_id])
		commentable.comments.create(comment: params[:comment], user_id: current_user.id)
		commentable.save
		flash[:notice] = "Comment Posted"
		redirect_to commentable
	end

	def destroy
		com = Comment.find(params[:id])
		@post = Micropost.find(com.commentable_id)
		com.destroy
		redirect_to @post
	end

	def vote_up
		comment = Comment.find(params[:id])
		comment.vote :voter => current_user
		redirect_to :back
	end

	def vote_down
		comment = Comment.find(params[:id])
		comment.vote :voter => current_user, :vote => 'bad'
		redirect_to :back
	end

	def comment_feed
		@post = Micropost.find(params[:micropost_id])
		@comments = @post.comments
	end

end
