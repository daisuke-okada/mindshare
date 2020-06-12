class UsersController < ApplicationController
	before_action :require_user_logged_in, only: [:index, :show, :edit]
	before_action :ensure_correct_user, only: [:edit, :update, :destroy]
	
	def index
		@users_pos = User.where(mind: "positive").order(id: :desc)
		@users_neg = User.where(mind: "negative").order(id: :desc)
		@user = User.find_by(id: params[:id])
	end
	def show
		@user = User.find_by(id: params[:id])
		
	end
	def new
		@user = User.new
		
	end
	def create
		@user = User.new(user_params)
		
		if @user.save
			flash[:success] = "ユーザを登録しました"
			redirect_to @user
		else
			flash[:danger] = "ユーザの登録に失敗しました"
			render :new
		end
		
	end
	def edit
		@user = User.find(params[:id])
	end
	def update
		@user = User.find(params[:id])
		
		if @user.update(user_params)
			flash[:success] = "User updated successfully"
			redirect_to @user
		else
			flash[:danger] = "User update failed"
			render :edit
		end
	end
	def destroy
		@user = User.find(params[:id])
		@user.destroy
		flash[:danger] = "Successfully deleted"
		redirect_to root_path
		
	end
	
	private
	
	def ensure_correct_user
		if @current_user.id != params[:id].to_i
			flash[:danger] = "you required authorizating"
			redirect_to users_path
			
		end 
		
	end 
	
	#Strong_parameter
	def user_params
		params.require(:user).permit(:name, :email, :mind, :password, :password_confirmation)
	end
	
end
