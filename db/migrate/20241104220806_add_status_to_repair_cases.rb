class AddStatusToRepairCases < ActiveRecord::Migration[7.0]
  def change
    add_column :repair_cases, :status, :integer, default: 0, null: false
  end
end
