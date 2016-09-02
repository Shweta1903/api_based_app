class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :ArticleTag
      t.references :article, index: true
      t.references :tag, index: true

      t.timestamps
    end
  end
end
