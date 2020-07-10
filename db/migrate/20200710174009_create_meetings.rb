class CreateMeetings < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings do |t|
      t.string :name
      t.datetime :start_time
      t.integer :user_id
      t.string :memo
      t.string :place

      t.timestamps
    end
    add_index :meetings, :user_id
    add_index :meetings, :memo
    add_index :meetings, :place
    add_index :meetings, :start_time
    add_index :meetings, :name
  end
end
