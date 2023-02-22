class Order < ApplicationRecord
  belongs_to :user
  belongs_to :stock
  before_validation :sell_value
  validate :sell_amount_true
  enum :order_action, {buy: 0, sell: 1}
  

  private

  def sell_value
    fund = self.fund * (sell? ? -1 : 1)
    self.quantity = fund / unit_price
  end

  def sell_amount_true
    return if buy?

    user_quantity = user.current_unit_owned(stock.symbol)
    return if fund <= user_quantity * unit_price

    errors.add(:fund, "")
  end
end
