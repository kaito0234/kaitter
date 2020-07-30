class AddTextColorToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :textColor, :string
  end
end
