class UsersController < ApplicationController
	before_action :require_user_logged_in, only: [:index, :show]
	
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
		
	end
	def update
		
	end
	def destroy
		
	end
	
	
	
	#Strong_parameter
	def user_params
		params.require(:user).permit(:name, :email, :mind, :password, :password_confirmation)
	end
	
end
