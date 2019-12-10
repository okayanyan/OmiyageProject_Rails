class User < ApplicationRecord
  has_many :post, dependent: :destroy
  attr_accessor :remember_token
  validates :name, presence: true, length: {maximum: 20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: {maximum: 20}, allow_nil: true

  before_save :downcase_email

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
