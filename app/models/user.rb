class User < ApplicationRecord
  before_validation :auto_approve_admin, on: :create

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  enum role: [:buyer, :broker, :admin]
  enum status: {pending: 0, approved: 1}
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :buyer 
  end

  def auto_approve_admin
    self.status = admin? ? :approved : :pending
  end
end