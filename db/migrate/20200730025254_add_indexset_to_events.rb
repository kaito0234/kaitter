class AddIndexsetToEvents < ActiveRecord::Migration[5.1]
  def change
    add_index :events, :allDay
    add_index :events, :textColor
  end
end
