require 'rails_helper'
RSpec.describe "API::V1::Session", type: :request do
  describe "POST /api/v1/session" do
    let(:user) { FactoryBot.create(:user) }

    context "有効なパラメータの場合" do
      it "トークンが返ること" do
        post "/api/v1/session", params: {
          session: {
            email: user.email,
            password: user.password
          }
        }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key("token")
      end
    end
    context "パスワードが間違っている場合" do
      it "401が返ること" do
        post "/api/v1/session", params: {
          session: {
            email: user.email,
            password: "miss_password"
          }
        }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE /api/v1/session" do
    let(:user) { FactoryBot.create(:user) }
    context "リクエストを送った場合" do
      it "ログアウトされること" do
        delete "/api/v1/session"
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
