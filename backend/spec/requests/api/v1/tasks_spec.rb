require 'rails_helper'

RSpec.describe 'Api::V1::Tasks', type: :request do
  describe "GET /api/v1/tasks" do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }
    let!(:task) { create(:task, user: user, category: category) }

    context "認証している場合" do
      it "200が返ること" do
        get "/api/v1/tasks", headers: authorization_header(user)
        expect(response).to have_http_status(:ok)
      end
      it "自身のタスクが返ること" do
        get "/api/v1/tasks", headers: authorization_header(user)
        json = JSON.parse(response.body)
        expect(json["tasks"].length).to eq(1)
      end
      it "カテゴリー名が含まれること" do
        get "/api/v1/tasks", headers: authorization_header(user)
        json = JSON.parse(response.body)
        expect(json["tasks"][0]["category"]["name"]).to eq(category.name)
      end
    end

    context "認証していない場合" do
      it "401が返ること" do
        get "/api/v1/tasks"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST /api/v1/tasks" do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }
    let(:valid_params) { attributes_for(:task, category_id: category.id) }
    let(:invalid_params) { attributes_for(:task, title: "", category_id: category.id) }
    context "認証している場合" do
      it "201が返りタスクが作成されること" do
        expect {
          post "/api/v1/tasks",
          params: { task: valid_params },
          headers: authorization_header(user)
        }.to change(Task, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context "無効なパラメータの場合" do
      it "422が返り作成されないこと" do
        expect {
          post "/api/v1/tasks",
          params: { task: invalid_params },
          headers: authorization_header(user)
        }.to change(Task, :count).by(0)

        expect(response).to have_http_status(:unprocessable_content)
      end
    end

    context "認証していない場合" do
      it "401が返ること" do
        post "/api/v1/tasks"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /api/v1/tasks" do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }
    let!(:task) { create(:task, user: user, category: category) }

    context "認証している場合" do
      it "タスクが削除できること" do
        expect {
          delete "/api/v1/tasks/#{task.id}",
          headers: authorization_header(user)
        }.to change(Task, :count).by(-1)

        expect(response).to have_http_status(:ok)
      end
    end

    context "認証していない場合" do
      it "401が返ること" do
        delete "/api/v1/tasks/#{task.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "存在しないタスクの場合" do
      it "404が返ること" do
        delete "/api/v1/tasks/0", headers: authorization_header(user)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PATCH /api/v1/tasks" do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }
    let!(:task) { create(:task, user: user, category: category) }
    let(:update_params) { attributes_for(:task, name: "update_task", category_id: category.id) }
    let(:invalid_params) { attributes_for(:task, title: "", category_id: category.id) }

    context "認証している場合" do
      it "タスクが更新できること" do
        patch "/api/v1/tasks/#{task.id}",
        params: { task: update_params },
        headers: authorization_header(user)

        expect(response).to have_http_status(:ok)
      end
    end

    context "認証されてない場合" do
      it "401が返ること" do
        patch "/api/v1/tasks/0",
        params: { taks: update_params }

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "パラメータが不正な場合" do
      it "422が返ること" do
        patch "/api/v1/tasks/#{task.id}",
        params: { task: invalid_params },
        headers: authorization_header(user)
      end
    end

    context "存在しないタスクの場合" do
      it "404が返ること" do
        patch "/api/v1/tasks/0",
        params: { taks: update_params },
        headers: authorization_header(user)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
