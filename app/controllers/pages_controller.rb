class PagesController < ApplicationController
  def landing
  end

  def market
    @stock_market_list = Iex.most_active_stocks
    @stock_market_list.each do |stock|
      Stock.create(name: stock['company_name'],
                   symbol: stock['symbol'],
                   percent_change: stock['change_percent_s'],
                   unit_price: stock['latest_price'])
    end
    @stocks = Stock.where('id > ?', 10).order('id desc').limit(10)
  end
end
