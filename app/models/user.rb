class User < ApplicationRecord
  has_many :post, dependent: :destroy
  has_many :active_follow, class_name: "FollowUser",
              foreign_key: "following_user_id",
              dependent: :destroy
  has_many :passive_follow, class_name: "FollowUser",
              foreign_key: "target_user_id",
              dependent: :destroy
  has_many :target_user, through: :active_follow
  has_many :following_user, through: :passive_follow
  has_many :favorite, dependent: :destroy
  has_many :favorite_post, through: :favorite, source: :post

  attr_accessor :remember_token
  validates :name, presence: true, length: {maximum: 20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: {maximum: 20}, allow_nil: true

  before_save :downcase_email

  mount_uploader :image_key, ImageUploader

  # function
  #   ・function to save remember token for cookie
  # used
  #   ・save login information in cookie
  def remember_in_db
    create_remember_token
    update_attribute(:remember_digest, self.remember_token)
  end

  # function
  #   ・function to delete remember token for cookie
  # used
  #   ・logout
  def forget_in_db
    update_attribute(:remember_digest, nil)
  end

  # function
  #   ・function to authenticated by cookie
  # used
  #    。login by cookie
  def authenticated?(remember_token)
    return false if self.remember_digest.nil?
    BCrypt::Password.new(self.remember_digest).is_password?(remember_token)
  end

  # function
  #   ・function to follow
  # used
  #    ・update follow user list
  def follow(other_user)
    target_user << other_user if self != other_user
  end

  # function
  #   ・function to unfollow
  # used
  #    。update follow user list
  def unfollow(other_user)
    target_user.delete(other_user) if following?(other_user)
  end

  # function
  #   ・function to check to follow
  # used
  #    。follow button text
  def following?(other_user)
    target_user.include?(other_user)
  end

  # function
  #   ・function to regist favorite
  # used
  #   ・favorite button
  def favorite(post)
    favorite_post << post if !favorites?(post)
  end

  # function
  #   ・function to unregist favorite
  # used
  #    favorite button
  def unfavorite(post)
    favorite_post.delete(post) if favorites?(post)
  end

  # function
  #   ・function to check to regist favorite
  # used
  #   ・favorite button
  def favorites?(post)
    favorite_post.include?(post)
  end

  private
    # function
    #   ・function to change email address
    # used
    #   ・make it easy to check email
    def downcase_email
      self.email.downcase!
    end

    # function
    #   ・function to create remember token for cookie
    # used
    #   ・save login information in cookie
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
