class CreatePayoutRates < ActiveRecord::Migration[5.0]
  def change
    create_table :payout_rates do |t|
      t.string :country
      t.string :country_code
      t.decimal :earn, precision: 5, scale: 2

      t.timestamps
    end
  end
end
