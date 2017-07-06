class Post < ApplicationRecord
  belongs_to :user

  scope :post_order, ->{order created_at: :desc}

  has_many :comments, dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags

  validates :user, presence: true
  validates :title, presence: true, length: {maximum: Settings.post.title_max_size}
  validates :content, presence: true
end
