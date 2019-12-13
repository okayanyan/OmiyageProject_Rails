class AddIndexToFollowUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :follow_users, [:following_user_id, :target_user_id], unique: true
  end
end
