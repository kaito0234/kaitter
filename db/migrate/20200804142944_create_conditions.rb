class CreateConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :conditions do |t|
      t.integer :level
      t.datetime :date
      t.integer :user_id

      t.timestamps
    end
    add_index :conditions, :level
    add_index :conditions, :date
    add_index :conditions, :user_id
  end
end
