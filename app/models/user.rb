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

  attr_accessor :remember_token, :activation_token
  validates :name, presence: true, length: {maximum: 20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: {maximum: 20}, allow_nil: true

  before_create :prepare_activate
  before_save :downcase_email
  
  mount_uploader :image_key, ImageUploader

  # function
  #   ・function to save remember token for cookie
  # used
  #   ・save login information in cookie
  def remember_in_db
    self.remember_token = create_token
    update_attribute(:remember_digest, digest(self.remember_token))
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
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    return false if attribute == :activation and Time.zone.now > self.activated_at.since(2.hours)
    BCrypt::Password.new(digest).is_password?(token)
  end

  # function
  #   ・function to authenticate new user
  # used
  #    ・create new user
  def prepare_activate
    if !self.activated?
      self.activation_token = create_token
      self.activation_digest = digest(self.activation_token)
      self.activated_at = Time.zone.now
    end
  end

  # function
  #   ・function to authenticate new user
  # used
  #    ・create new user
  def activate
    update_attribute(:activated, true)
    update_attribute(:activation_digest, nil)
    update_attribute(:activated_at, Time.zone.now)
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
    #   ・function to digest
    # used
    #   ・make it be secured
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # function
    #   ・function to create token
    # used
    #   ・save login information in cookie
    #   ・save activation token
    def create_token
      SecureRandom.urlsafe_base64
    end

end
