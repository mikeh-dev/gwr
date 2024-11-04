class CreateRepairCases < ActiveRecord::Migration[7.0]
  def change
    create_table :repair_cases do |t|
      t.string :title
      t.text :details

      t.timestamps
    end
  end
end
