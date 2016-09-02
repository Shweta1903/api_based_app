class AddLikeableTypeColumnToLike < ActiveRecord::Migration
  def change
    add_column :likes, :likeable_type, :string
  end
end
