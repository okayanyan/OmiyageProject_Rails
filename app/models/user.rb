class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true, length: {maximum: 20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: {maximum: 20}, allow_nil: true

  private
    def downcase_email
      self.email.downcase!
    end
end
