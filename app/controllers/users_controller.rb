class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(role: "admin")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)

    if @user.save
      redirect_to users_path
    end

  end

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    if current_user.role = 'admin'
      if @user.update(create_user_params)
        redirect_to users_path
      else
        render :edit
      end
    end
  end
  private
  
  def create_user_params
    params.require(:user).permit(:email, :password, :confimation_password)
  end

end
