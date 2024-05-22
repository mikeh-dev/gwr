class AddAgreementNumbertoAgreements < ActiveRecord::Migration[7.0]
  def change
    add_column :agreements, :agreement_number, :string, null: false
  end
end
