class User < ApplicationRecord
  has_person_name
  has_one_attached :avatar

  enum role: { tenant: 0, landlord: 1, admin: 2 }

  has_many :properties, foreign_key: 'owner_id', class_name: 'Property'
  has_many :agreements_as_landlord, class_name: 'Agreement', foreign_key: 'landlord_id'
  has_many :agreements_as_tenant, class_name: 'Agreement', foreign_key: 'tenant_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
