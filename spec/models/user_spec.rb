require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = build(:user, role: "buyer")
  end

  context 'user role on create' do
    it 'role should be buyer by default' do
      @user.save
        expect(User.find(@user.id).role).to eq("buyer")
    end
  end
end
