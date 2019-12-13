class FollowUser < ApplicationRecord
  belongs_to :following_user, class_name: "User"
  belongs_to :target_user, class_name: "User"
  validates :following_user_id, presence: true
  validates :target_user_id, presence: true
end
