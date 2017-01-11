class AddTypeToOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :options, :datatype, :string
  end
end
