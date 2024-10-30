class AddRenewalDateToAgreements < ActiveRecord::Migration[7.0]
  def change
    add_column :agreements, :renewal_date, :date
  end
end
