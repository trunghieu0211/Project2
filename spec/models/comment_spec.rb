require "rails_helper"

RSpec.describe Comment, type: :model do
  context "associations" do
    it{is_expected.to belong_to :post}
    it{is_expected.to belong_to :user}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :user}
    it{is_expected.to validate_presence_of :post}
    it{is_expected.to validate_presence_of :content}
    it do
      is_expected.to validate_length_of(:content)
        .is_at_most Settings.comment.comment_max_size
    end
  end
end
