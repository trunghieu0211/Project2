class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: [:facebook]

  scope :user_order, ->{order created_at: :desc}

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true, length: {maximum: Settings.user.name_max_size}
  validates :phone, length: {maximum: Settings.user.phone_max_size}

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  class << self
    def array_hot_user
      joins(:followers).group("users.id").count.sort_by{|_key, value| value}
        .reverse.first Settings.user.number_user_follower
    end

    def hot_user
      return unless User.array_hot_user.count > 0
      User.find User.array_hot_user.transpose[0]
    end

    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.name = auth.info.name
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
      end
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] &&
            session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end
