class RenameDateColumnToConditions < ActiveRecord::Migration[5.2]
  def change
    rename_column :conditions, :date, :datetime
  end
end
