class AddAgreementAssociationToRepairCases < ActiveRecord::Migration[7.0]
  def change
    add_reference :repair_cases, :agreement, foreign_key: true
  end
end
