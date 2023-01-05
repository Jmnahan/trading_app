class User < ApplicationRecord
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
    self.status ||= :pending
  end
  
end