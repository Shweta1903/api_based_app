class AddPinColumnToArticles < ActiveRecord::Migration
  def change
    add_reference :articles, :pin, index: true, foreign_key: true
  end
end
