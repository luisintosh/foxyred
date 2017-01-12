class CreateBalances < ActiveRecord::Migration[5.0]
  def change
    create_table :balances do |t|
      t.references :user, foreign_key: true
      t.decimal :publisher_earnings, precision: 15, scale: 5, default: 0.0,  null: false
      t.decimal :referral_earnings, precision: 15, scale: 5,  default: 0.0,  null: false

      t.timestamps
    end
  end
end
