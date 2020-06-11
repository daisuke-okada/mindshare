class UsersController < ApplicationController
	
	def index
		@users_pos = User.where(status: "Positive").order(id: :desc).page(params[:page]).per(25)
		@users_neg = User.where(status: "negative").order(id: :desc).page(params[:page]).per(25)
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
