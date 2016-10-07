class AddColumnEventCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :user_id, :integer
    add_index :events, :user_id
    add_column :events, :category_id, :integer
    add_index :events, :category_id
  end
end
