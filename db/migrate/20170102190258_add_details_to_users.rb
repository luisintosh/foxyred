class AddDetailsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :integer
    add_column :users, :referred_by, :integer
    add_column :users, :referral_code, :string
    add_index :users, :referral_code, unique: true
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address, :string
    add_column :users, :tel, :string
    add_column :users, :withdrawal_method, :string
    add_column :users, :withdrawal_account, :string
  end
end
