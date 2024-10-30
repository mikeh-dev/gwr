class RemoveLandlordFromAgreements < ActiveRecord::Migration[7.0]
  def change
    remove_column :agreements, :landlord_id
  end
end
