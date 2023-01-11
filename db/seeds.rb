# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all

admin = User.new email: 'admin1@email.com', password: 'password', role: :admin
admin.skip_confirmation!
admin.save

Iex.most_active_stocks.each do |stock|
  Stock.create name: stock['company_name'], symbol: stock['symbol']
end

stocks = Stock.all

10.times do |n|
  user = User.new email: "user#{n}@email.com", password: 'password'
  user.skip_confirmation!
  user.save
  
  5.times do

    stock = stocks.sample
    quote = Iex.client.quote stock.symbol
    percent_change = quote['change_percent_s']
    unit_price = quote['latest_price']
    fund = rand(1..unit_price)
    quantity = fund / unit_price

    Order.create user:, stock: stocks.sample, fund:, percent_change:, order_action: [:buy, :sell].sample,
    unit_price:, quantity:
  end
end
