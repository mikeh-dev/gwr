class CreateAgreements < ActiveRecord::Migration[7.0]
  def change
    create_table :agreements do |t|
      t.integer :length
      t.date :start_date
      t.date :end_date
      t.integer :notice_period
      t.decimal :monthly_rent_amount
      t.references :property, null: false, foreign_key: true
      t.references :landlord, null: false, foreign_key: { to_table: :users }
      t.references :tenant, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
