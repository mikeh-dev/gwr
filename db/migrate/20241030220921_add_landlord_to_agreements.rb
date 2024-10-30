class AddLandlordToAgreements < ActiveRecord::Migration[7.0]
  def change
    add_reference :agreements, :landlord, foreign_key: { to_table: :users }
  end
end