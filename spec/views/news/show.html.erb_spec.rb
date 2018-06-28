require 'rails_helper'

RSpec.describe "news/show", type: :view do
  it "displays contents" do
    news = create :news, title: "title", content: "content"
    assign(:news, news)
    assign(:popular_courses, [])
    assign(:latest_news, [])
    render
    expect(rendered).to have_content "title"
    expect(rendered).to have_content "content"
  end
end
