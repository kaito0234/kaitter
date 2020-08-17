class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :state
      t.text :task
      t.text :memo
      t.text :color
      t.date :limit_date
      t.integer :user_id

      t.timestamps
    end
    add_index :tasks, :state
    add_index :tasks, :task
    add_index :tasks, :memo
    add_index :tasks, :color
    add_index :tasks, :limit_date
    add_index :tasks, :user_id
  end
end
