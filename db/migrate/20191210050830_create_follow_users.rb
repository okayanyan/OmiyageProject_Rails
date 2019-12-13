class CreateFollowUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :follow_users do |t|
      t.references :following_user, foreign_key:  { to_table: :users }
      t.references :target_user, foreign_key:  { to_table: :users }

      t.timestamps
    end
  end
end