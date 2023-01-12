class OrdersController < ApplicationController
  before_action :find_stock

  def new
    @order = Order.new(stock: @stock, user: current_user, unit_price: @stock_quote.latest_price)
  end

  def create
  end

  private

  def find_stock
    @stock = Stock.find(params[:stock_id])
    @stock_quote = Iex.client.quote(@stock.symbol)
  end
end
