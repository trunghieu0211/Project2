require "rails_helper"

RSpec.describe User, type: :model do
  context "associations" do
    it{is_expected.to have_many :posts}
    it{is_expected.to have_many :comments}
    it{is_expected.to have_many :active_relationships}
    it{is_expected.to have_many :passive_relationships}
    it{is_expected.to have_many :following}
    it{is_expected.to have_many :followers}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :name}
    it do
      is_expected.to validate_length_of(:name)
        .is_at_most Settings.user.name_max_size
    end
    it do
      is_expected.to validate_length_of(:phone)
        .is_at_most Settings.user.phone_max_size
    end
  end
end
