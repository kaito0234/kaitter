class AddCheckedToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :checked, :boolean
  end
end
