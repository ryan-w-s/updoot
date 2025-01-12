class CreateDoots < ActiveRecord::Migration[7.0]
  def change
    create_table :doots do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.integer :value, null: false, default: 0

      t.timestamps
    end
  end
end
