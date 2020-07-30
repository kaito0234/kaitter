class AddIndexToEvents < ActiveRecord::Migration[5.1]
  def change
    remove_index :events, :allday
  end
end
