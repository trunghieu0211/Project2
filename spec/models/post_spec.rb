require "rails_helper"

RSpec.describe Post, type: :model do
  context "associations" do
    it{is_expected.to belong_to :user}
    it{is_expected.to have_many :comments}
    it{is_expected.to have_many :post_tags}
    it{is_expected.to have_many :tags}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :user}
    it{is_expected.to validate_presence_of :title}
    it{is_expected.to validate_presence_of :content}
    it do
      is_expected.to validate_length_of(:title)
        .is_at_most Settings.post.title_max_size
    end
  end
end
