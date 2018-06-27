require 'rails_helper'

RSpec.describe NewsController, type: :controller do

  let(:news) {create :news}

  describe "GET #index" do
    before {get :index}
    it "populates an array of all newss" do
      news_a = create :news
      news_b = create :news
      expect(assigns :newses).to match_array [news_a, news_b]
    end
    it "render :index template" do
      is_expected.to render_template :index
    end
  end

  describe "GET #show" do
    context "found news" do
      before {get :show, params: {id: news}}
      it "assigns the request news to @news" do
        expect(assigns :news).to eq news
      end
      it "renders the :show template" do
        is_expected.to render_template :show
      end
    end

    context "not found news" do
      it "redirects to news#index" do
        get :show, params: {id: News.all.count + 1}
        is_expected.to redirect_to root_path
      end
    end
  end
end
