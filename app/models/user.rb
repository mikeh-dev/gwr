class User < ApplicationRecord
  has_person_name
  has_one_attached :avatar

  enum role: {tenant: 0, landlord: 1, admin: 2}

  has_many :properties, foreign_key: 'owner_id', class_name: 'Property'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
