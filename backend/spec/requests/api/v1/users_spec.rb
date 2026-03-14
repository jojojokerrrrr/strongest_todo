require 'rails_helper'
RSpec.describe 'Api::V1::Users', type: :request do
  describe "POST /api/v1/users" do
    let(:valid_params) { { user: attributes_for(:user) } }
    let(:invalid_params) { { user: { name: "", email: "email", password: "1" } } }

    context "有効なパラメータである場合" do
      it "ユーザーが作成できること" do
        expect {
          post "/api/v1/users", params: valid_params
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context "無効なパラメータの場合" do
      it "ユーザーが作成できないこと" do
        expect {
          post "/api/v1/users", params: invalid_params
        } .not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE /api/v1/users" do
    let!(:user) { create(:user) }

    context "認証している場合" do
      it "自身のアカウントを削除できること" do
        expect {
          delete "/api/v1/users/#{user.id}", headers: authorization_header(user)
      }.to change(User, :count).by(-1)

      expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "PATCH /api/v1/users" do
    let!(:user) { FactoryBot.create(:user) }
    let(:update_params) { { name: "update_name" } }

    context "認証していて正しいパラメータの場合" do
      it "ユーザーが更新できること" do
        put "/api/v1/users/#{user.id}", params: { user: update_params }, headers: authorization_header(user)
        expect(response).to have_http_status(:ok)

        expect(user.reload.name).to eq("update_name")
      end
    end

    context "認証していない場合" do
      it "更新に失敗すること" do
        put "/api/v1/users/#{user.id}", params: { user: update_params }

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "不正なパラメータの場合" do
      it "更新に失敗すること" do
        put "/api/v1/users/#{user.id}", params: { user: { name: "" } }, headers: authorization_header(user)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end
end
