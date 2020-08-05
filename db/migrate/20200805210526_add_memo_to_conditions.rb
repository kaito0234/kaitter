class AddMemoToConditions < ActiveRecord::Migration[5.2]
  def change
    add_column :conditions, :memo, :string
  end
end
