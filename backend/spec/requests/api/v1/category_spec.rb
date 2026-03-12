require 'rails_helper'

RSpec.describe "Api::V1::Categories", type: :request do
  describe "GET /api/v1/categories" do
    let!(:category) { FactoryBot.create(:category) }
    it "200が返ること" do
      get "/api/v1/categories"
      expect(response).to have_http_status(:ok)
    end

    it "カテゴリー一覧が返ること" do
      get "/api/v1/categories"
      json =JSON.parse(response.body)
      expect(json["categories"].length).to eq(1)
    end
  end
end
