class RenameAlldayColumnToEvents < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :allday, :allDay
  end
end
