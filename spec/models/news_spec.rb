require 'rails_helper'

RSpec.describe News, type: :model do
  it do
    is_expected.to validate_presence_of(:title)
      .with_message I18n.t "activerecord.errors.models.news.attributes.title.blank"
  end

  it do
    is_expected.to validate_presence_of(:content)
      .with_message I18n.t "activerecord.errors.models.news.attributes.content.blank"
  end

  it do
    is_expected.to belong_to :admin
  end

  it do
    is_expected.to have_one :image
  end

  it do
    is_expected.to accept_nested_attributes_for :image
  end
end
