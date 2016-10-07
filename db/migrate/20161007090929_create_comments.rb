class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.timestamps
    end
  end
  add_column :events, :comment_id, :integer
  add_column :users, :comment_id, :integer
  add_index :events, :comment_id
  add_index :users, :comment_id
end
