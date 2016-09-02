class CreateArticleVotes < ActiveRecord::Migration
  def change
    create_table :article_votes do |t|
      t.references :article, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
