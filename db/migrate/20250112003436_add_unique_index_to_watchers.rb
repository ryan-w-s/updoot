class AddUniqueIndexToWatchers < ActiveRecord::Migration[7.0]
  def change
    add_index :watchers, [:user_id, :collection_id], unique: true
  end
end
