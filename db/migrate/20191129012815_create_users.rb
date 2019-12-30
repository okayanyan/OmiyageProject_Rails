class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, :limit=>20
      t.string :email, unique: true
      t.string :password_digest

      t.timestamps
    end
  end
end
