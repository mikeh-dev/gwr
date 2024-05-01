class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :title
      t.string :address
      t.string :postcode
      t.string :city
      t.string :property_type
      t.integer :owner_id

      t.timestamps
    end
  end
end
