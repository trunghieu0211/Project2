class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :comment_order, ->{order updated_at: :desc}

  validates :user, :post, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.comment.comment_max_size}
end
