class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :voter_id
      t.references :article, index: true
      t.boolean :vote_status

      t.timestamps
    end
  end
end
