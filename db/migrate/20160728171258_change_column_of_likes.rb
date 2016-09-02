class ChangeColumnOfLikes < ActiveRecord::Migration
  def change
  	rename_column :likes, :Liker_id, :liker_id
  end
end
