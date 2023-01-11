class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(role: 'admin')
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

  def view_transactions 
    @orders = Order.includes(:order_action,:user).all.order(:created_at => :DESC)
    
  end

  def pending
    @pending_users = User.where(status: 'pending')
  end

  def approve
    @user = User.find params[:id]
    @user.update(status: params[:status])
    
    if @user.approved! 
      AdminMailer.with(user: @user).approve_user_email.deliver_later
      redirect_to notifications_path, notice: "#{@user.email} has been approved"
    else
      redirect_to notifications_path, alert: "something wrong, please call administrator"
    end 
  end

  def buy_order
    
  end

  def sell_order

  end

  def transaction
    @user = User.find params[:id]

    if @user.role == "buyer"
      @user_orders = current_user.orders
    end

    if @user.role == "admin"
      @user_orders = Order.all.order(created_at: :desc)
    end
  end

  private
  
  def create_user_params
    params.require(:user).permit(:email, :password, :confimation_password, :role, :status,)
  end

end
