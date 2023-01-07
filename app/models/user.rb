class User < ApplicationRecord
  has_many :orders
  has_many :stocks, through: :orders
  after_initialize :set_default_role, :if => :new_record?
  before_validation :set_status, on: :create
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  enum role: [:buyer, :admin]
  enum status: [:pending, :approved]

  private

  def set_default_role
    self.role ||= :buyer 
  end

  def set_status
    self.status = admin? ? :approved : :pending
  end
  
end