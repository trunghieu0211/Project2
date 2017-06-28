require "rails_helper"

RSpec.describe Tag, type: :model do
  context "associations" do
    it{is_expected.to have_many :post_tags}
    it{is_expected.to have_many :posts}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :name}
    it do
      is_expected.to validate_length_of(:name)
        .is_at_most Settings.tag.tag_max_size
    end
  end
end
