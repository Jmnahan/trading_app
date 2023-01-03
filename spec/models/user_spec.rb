require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = build(:user, role: "buyer")
    @user.skip_confirmation!
  end

  context 'user role on create' do
    it 'role should be buyer by default' do
      @user.save
        expect(User.find(@user.id).role).to eq('buyer')
    end
  end

  context 'user status on create' do
    it 'status should be pending by default' do
      @user.save
        expect(User.find(@user.id).status).to eq('pending')
    end
  end
end
