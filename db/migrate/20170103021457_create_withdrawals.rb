class CreateWithdrawals < ActiveRecord::Migration[5.0]
  def change
    create_table :withdrawals do |t|
      t.references :user, foreign_key: true
      t.string :transaction_id
      t.string :status
      t.string :method
      t.string :account
      t.decimal :amount, precision: 15, scale: 5
      t.decimal :referral_earnings, precision: 15, scale: 5
      t.decimal :publisher_earnings, precision: 15, scale: 5

      t.timestamps
    end
  end
end