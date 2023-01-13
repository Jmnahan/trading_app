class OrdersController < ApplicationController
  before_action :find_stock
  
  def new
    @order = Order.new(stock: @stock, user: current_user, unit_price: @stock_quote.latest_price)
  end

  def create
    @order = Order.new order_params
    
    if @order.save
      redirect_to new_stock_order_path
    else
      render :new
    end
  end

  private

  def find_stock
    @stock = Stock.find(params[:stock_id])
    @stock_quote = Iex.client.quote(@stock.symbol)
  end

  def order_params
    order_form = params.require(:order)
    unit_price = @stock_quote.latest_price
    order_action = order_form[:order_action].to_sym
    fund = order_form[:order_amount].to_f
    quantity = fund / unit_price
    {stock: @stock, user: current_user, unit_price:, order_action:, fund:, quantity:}
  end
end
