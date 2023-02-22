class User < ApplicationRecord
  has_many :orders
  has_many :stocks, through: :orders
  after_initialize :set_default_role, :if => :new_record?
  before_validation :set_status, on: :create
  
  has_many :stocks
  has_many :orders
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  enum role: [:buyer, :admin]
  enum status: [:pending, :approved]

  def funds_sum
    orders.sum(:fund)
  end

  def current_unit_owned(symbol)
    orders.group_by{ |order| order.stock.symbol }[symbol]&.sum(&:quantity) || 0
  end

  def current_holdings
    orders.each_with_object({}) do |g,h|
      h.update(Stock.find(g[:stock_id]).symbol=>g) do |_,o,n|
      { unit_price: n[:unit_price],
        percent_change: o[:percent_change],
        fund: o[:fund]+n[:fund], 
        quantity: o[:quantity]+n[:quantity] 
      }
      end
    end
  end

  private

  def set_default_role
    self.role ||= :buyer 
  end

  def set_status
    self.status = admin? ? :approved : :pending
  end
  
end