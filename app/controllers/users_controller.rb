class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(role: "admin")
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    if @user.role_type = 'admin'
      @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  private
end
