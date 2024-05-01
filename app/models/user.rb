class User < ApplicationRecord
  has_person_name
  has_one_attached :avatar

  enum role: [admin: 0, landlord: 1, tenant: 2]

  has_many :properties, foreign_key: 'owner_id'


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
