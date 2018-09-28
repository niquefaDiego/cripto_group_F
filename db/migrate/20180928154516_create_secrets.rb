class CreateSecrets < ActiveRecord::Migration[5.2]
  def change
    create_table :secrets do |t|
      t.string :ciphertext
      t.integer :algorithm

      t.timestamps
    end
  end
end
