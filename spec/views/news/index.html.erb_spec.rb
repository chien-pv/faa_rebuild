require 'rails_helper'

RSpec.describe "news/index", type: :view do
  it "displays contents" do
    news_a = create :news, title: "title", content: "content"
    assign(:newses, Kaminari.paginate_array([news_a]).page(1))
    assign(:popular_courses, [])
    assign(:latest_news, [])
    render
    expect(rendered).to have_content "title"
    expect(rendered).to have_content "content"
  end
end

