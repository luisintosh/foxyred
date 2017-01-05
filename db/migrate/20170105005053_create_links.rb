class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.references :user, foreign_key: true
      t.string :status
      t.string :url
      t.string :alias
      t.integer :hits
      t.integer :real_hits

      t.timestamps
    end
    add_index :links, :alias, unique: true
  end
end
