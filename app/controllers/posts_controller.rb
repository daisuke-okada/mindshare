class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy] 
  
  def index
    @posts_pos = Post.where(status: "positive").order(id: :desc)
    @posts_neg = Post.where(status: "negative").order(id: :desc)
  end
  def show
    @post = Post.find_by(id: params[:id])
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
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: params[:id])
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
    @users_pos = User.where(mind: "positive")
    @pos_pos = feed_posts_pos.where(status: "positive")
  end
  
  
  def posneg
    @users_neg = User.where(mind: "negative")
    @pos_neg = feed_posts_neg.where(status: "positive")
  end
  def negpos
    @users_pos = User.where(mind: "positive")
    @neg_pos = feed_posts_pos.where(status: "negative")
  end
  def negneg
    @users_neg = User.where(mind: "negative")
    @neg_neg = feed_posts_neg.where(status: "negative")
  end
  
  private
  #strong_parameter
  def post_params
		params.require(:post).permit(:content, :status)
		
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
