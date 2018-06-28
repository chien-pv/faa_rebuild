require 'rails_helper'

RSpec.describe V1::NewsesController, type: :controller do
  let(:admin) {create :admin}
  let(:news) {create :news}
  let(:newses) {create_list :news, 5}

  describe "GET #index" do
    before {
      request.headers["AUTHORIZATION"] = admin.authentication_token
      get :index
    }

    it "returns a successful 200 response" do
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE #destroy" do
    context "found news" do
      before {
        request.headers["AUTHORIZATION"] = admin.authentication_token
        delete :destroy, params: {id: news.id}
      }

      it "assigns news" do
        expect(assigns :news).to eq news
      end

      it "delete success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "not found news" do
      before {
        request.headers["AUTHORIZATION"] = admin.authentication_token
        delete :destroy, params: {id: 0}
      }

      it "response not found" do
        body = JSON.parse(response.body)
        expect(body["status"]).to eq(404)
      end
    end
  end

  describe "POST #create" do
    context "create success" do
      before {
        request.headers["AUTHORIZATION"] = admin.authentication_token
        post :create, params: {title: news.title, content: news.content}
      }

      it "create success" do
        body = JSON.parse(response.body)
        expect(body["status"]).to eq(200)
        expect(body["content"]["title"]).to eq(news.title)
        expect(body["content"]["content"]).to eq(news.content)
      end
    end

    context "create fail" do
      before {
        request.headers["AUTHORIZATION"] = admin.authentication_token
        post :create, params: {title: "", content: ""}
      }

      it "create fail" do
        body = JSON.parse(response.body)
        expect(body["status"]).to eq(400)
      end
    end
  end

  describe "GET #edit" do
    context "found news" do
      before {
        request.headers["AUTHORIZATION"] = admin.authentication_token
        get :edit, params: {id: news.id}
      }

      it "assigns news" do
        expect(assigns :news).to eq news
      end
    end

    context "not found news" do
      before {
        request.headers["AUTHORIZATION"] = admin.authentication_token
        get :edit, params: {id: 0}
      }

      it "response not found" do
        body = JSON.parse(response.body)
        expect(body["status"]).to eq(404)
      end
    end
  end

  describe "PATCH #update" do
    context "found news and update not success" do
      before {
        request.headers["AUTHORIZATION"] = admin.authentication_token
        patch :update, params: {id: news.id, title: "", content: ""}
      }

      it "assigns news" do
        expect(assigns :news).to eq news
      end

      it "response update fail" do
        body = JSON.parse(response.body)
        expect(body["status"]).to eq(400)
      end
    end

    context "not found news" do
      before {
        request.headers["AUTHORIZATION"] = admin.authentication_token
        patch :update, params: {id: 0}
      }
      it "response not found" do
        body = JSON.parse(response.body)
        expect(body["status"]).to eq(404)
      end
    end
  end
end
