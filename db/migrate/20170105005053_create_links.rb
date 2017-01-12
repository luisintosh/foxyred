class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.references :user, foreign_key: true
      t.integer :status
      t.string :url
      t.string :alias
      t.integer :hits       default: 0,  null: false
      t.integer :real_hits  default: 0,  null: false

      t.timestamps
    end
    add_index :links, :alias, unique: true
  end
end
