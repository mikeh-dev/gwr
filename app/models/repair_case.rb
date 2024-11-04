class RepairCase < ApplicationRecord
  belongs_to :agreement

  validates :title, :details, presence: true

end