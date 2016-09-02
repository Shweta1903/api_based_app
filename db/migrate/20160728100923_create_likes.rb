class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :Liker_id
      t.references :user, index: true
      t.boolean :like_status

      t.timestamps
    end
  end
end
