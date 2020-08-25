class ChangeCheckedOfTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :checked, :boolean, :default => false
  end
end
