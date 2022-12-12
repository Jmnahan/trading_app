require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /landing" do
    before do
      get root_path
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

end
