class Tag < ApplicationRecord
  has_many :post_tags
  has_many :posts, through: :post_tags

  before_save :downcase_tag_name

  validates :name, presence: true, uniqueness: true,
    length: {maximum: Settings.tag.tag_max_size}

  private

  def downcase_tag_name
    name.downcase!
  end
end
