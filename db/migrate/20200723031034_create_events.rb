class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :title
      t.text :memo
      t.string :place
      t.datetime :start
      t.datetime :end
      t.string :color
      t.boolean :allDay
      t.string :textColor

      t.timestamps
    end
    add_index :events, :user_id
    add_index :events, :title
    add_index :events, :memo
    add_index :events, :place
    add_index :events, :start
    add_index :events, :end
    add_index :events, :color
    add_index :events, :allDay
    add_index :events, :textColor
  end
end
