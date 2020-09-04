class AddLoginconditionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :logincondition, :boolean, :default => false
  end
end
