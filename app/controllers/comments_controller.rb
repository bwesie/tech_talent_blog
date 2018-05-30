class CommentsController < ApplicationController
	before_action :set_comment, only: [:edit, :update, :destroy]

	include ApplicationHelper

	def index
    	@comments = Comment.all
  	end

	def edit
		@blog_post = BlogPost.find(@comment.blog_post_id)
		no_access_visistors(current_user, @comment)
	end

	def show
  	end

	def new
    	@comment = Comment.new
  	end

	def create
		@comment = Comment.new(comment_params)

		respond_to do |format|
			if @comment.save
				format.html { redirect_to blog_post_url(id: @comment.blog_post_id), notice: "Comment successfully created" }
			else
				format.html { redirect_back fallback_location: root_path }
			end
		end
	end

	def update
		respond_to do |format|
			if @comment.update(comment_params)
				format.html { redirect_to blog_post_url(id: @comment.blog_post_id), notice: "Comment successfully updated" }
			else
				format.html { render :edit }
			end
		end
	end

	def destroy
		@comment.destroy

		respond_to do |format|
			format.html { redirect_to blog_post_url(id: @comment.blog_post_id), notice: "Comment successfully deleted"}
		end
	end

	private
	def set_comment
		@comment = Comment.find(params[:id])
	end

	def comment_params
		params.require(:comment).permit(:user_id, :comment_entry, :blog_post_id)
	end
end
