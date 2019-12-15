class Post < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  has_many :favorite
  has_many :favorite_user, through: :favorite, source: :user
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 30}
  validates :prefecture_id, presence: true
  validates :evaluation, presence: true
  validates :content, presence: true, length: {maximum: 1000}

  mount_uploader :image_key, ImageUploader
end
