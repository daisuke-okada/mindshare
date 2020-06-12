class PostsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @posts_pos = Post.where(status: "positive").order(id: :desc)
    @posts_neg = Post.where(status: "negative").order(id: :desc)
  end
  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:success] = "Action posted successfully"
      redirect_to @post
    else
      flash[:danger] = "Action posted failed"
      render :new
    end 
  end
  def edit
    @post = Post.find(params[:id])
  end
  def update
    @post = Post.find(params[:id])
    
    if @post.update(post_params)
      flash[:success] = "Action updated successfully"
      redirect_to @post
    else
      flash[:danger] = "Action update failed"
      render :edit
    end 
  end
  def destroy
    @post = Action.find(params[:id])
    @post.destroy
    flash[:danger] = "Successfully deleted"
    redirect_to posts_path
  end
  def pospos
    @posts_pos = Post.users.where(status: "positive")
    @users_pos = User.where(mind: "positive")
  end
  def posneg
    @posts_pos = Post.where(status: "positive")
    @users_neg = User.where(mind: "negative")
  end
  def negpos
    @posts_neg = Post.where(status: "negative")
    @users_pos = User.where(mind: "positive")
  end
  def negneg
    @posts_neg = Post.where(status: "negative")
    @users_neg = User.where(mind: "negative")
  end
  
  private
  #strong_parameter
  def post_params
		params.require(:post).permit(:content, :status)
		
  end
end
