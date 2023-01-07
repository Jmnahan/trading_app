class Order < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  enum :order_action, {buy: 0, sell: 1}
end
