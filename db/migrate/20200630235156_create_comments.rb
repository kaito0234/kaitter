class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps
    end
    add_index:comments, :user_id
    add_index:comments, :micropost_id
    add_index:comments, :text
  end
end
