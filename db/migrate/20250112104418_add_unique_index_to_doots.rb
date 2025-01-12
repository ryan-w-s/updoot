class AddUniqueIndexToDoots < ActiveRecord::Migration[7.0]
  def change
    add_index :doots, [:user_id, :post_id], unique: true
  end
end
