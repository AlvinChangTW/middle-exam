class RemoveColumnCommentIdToEvent < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :comment_id
  end
end
