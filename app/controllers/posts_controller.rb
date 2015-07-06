class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :tagged]
	
	def index
		@q = Post.ransack(params[:q])
		@posts = @q.result(distinct:true).order("created_at DESC")
	end

	def show
		@post = Post.find(params[:id])
		@user = User.all
		@post_comment = PostComment.new(:post_id => @post.id)
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(params[:post])
		if @post.save
			redirect_to posts_path, :notice => "Your post has been saved."
		else
			render "new"
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(params[:post])
			redirect_to post_path, :notice => "Your post has been updated."
		else
			render "edit"
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path, :notice => "Your post has been deleted."
	end

	def tagged
		if params[:tag].present?
			@posts = Post.tagged_with(params[:tag])
		else
			@posts = Post.all
		end
	end

	def liked 
		@post = Post.find(params[:id])
		@post.liked_by current_user
		redirect_to posts_path
	end

	def unliked
		@post = Post.find(params[:id])
		@post.unliked_by current_user
		redirect_to posts_path
	end 
	#def tags
	#	@users = User.where("LOWER(name) LIKE ?", "%#{params[:q]}%").order(:name)
	#	@categories = Category.where("name LIKE ?", "%#{params[:q]}%").order(:name)
	#	respond_to do |format|
	#		format.json {render :json => @users + @categories, :only =>[:id, :name]}
	#	end
	#end
end
