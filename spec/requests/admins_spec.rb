require 'rails_helper'

RSpec.describe "Admins", type: :request do
  let(:user) {create :user}

  before :each do 
    @admin = create(:user, role: "admin")

    sign_in @admin
  end

  describe "get home/users/new" do
    it "gets new user as admin" do
      get new_user_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "get home/users/:id/edit" do
    it "gets user and edit as admin" do
      get edit_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /home/index" do
    it "returns the users index page" do
      get users_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /home/user" do
    it "returns the user page" do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
  end
end