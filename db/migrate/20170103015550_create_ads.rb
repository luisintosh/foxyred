class CreateAds < ActiveRecord::Migration[5.0]
  def change
    create_table :ads do |t|
      t.boolean :default
      t.string :position
      t.string :network
      t.text :code
      t.string :type
      t.decimal :price, precision: 10, scale: 5
      t.string :traffic_source
      t.string :countries
      t.datetime :start_date
      t.datetime :end_date
      t.integer :weight

      t.timestamps
    end
  end
end
