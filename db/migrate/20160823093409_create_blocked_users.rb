class CreateBlockedUsers < ActiveRecord::Migration
  def change
    create_table :blocked_users do |t|
      t.integer :blocker_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
