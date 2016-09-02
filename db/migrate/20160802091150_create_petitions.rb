class CreatePetitions < ActiveRecord::Migration
  def change
    create_table :petitions do |t|
      t.references :article, index: true
      t.boolean :mail_sent

      t.timestamps
    end
  end
end
