require "rails_helper"

RSpec.describe PostTag, type: :model do
  context "associations" do
    it{is_expected.to belong_to :post}
    it{is_expected.to belong_to :tag}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :post}
    it{is_expected.to validate_presence_of :tag}
  end
end
