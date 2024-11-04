class RepairCase < ApplicationRecord
  belongs_to :agreement
  has_many_attached :repair_case_images

  validates :title, :details, :status, presence: true

  enum status: { open: 0, resolved: 1 }

end