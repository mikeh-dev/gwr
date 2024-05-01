class AddingIndexToProperty < ActiveRecord::Migration[7.0]
  def change
    add_index :properties, :owner_id
    add_foreign_key :properties, :users, column: :owner_id
  end
end
