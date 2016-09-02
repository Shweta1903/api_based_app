class AddLikeableColumnToLike < ActiveRecord::Migration
  def change
    add_column :likes, :likeable_id, :integer
  end
end
