class ChangePropertyTypeInProperties < ActiveRecord::Migration[7.0]
  def change
    remove_column :properties, :property_type, :string
    add_column :properties, :property_type, :integer
  end
end
