class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :image_key
      t.references :prefecture, foreign_key: true
      t.integer :evaluation
      t.text :content

      t.timestamps
    end
    add_index :posts, [:user_id, :prefecture_id, :created_at]
  end
end
