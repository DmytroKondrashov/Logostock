class Location < ApplicationRecord
    has_many :companies_locations, dependent: :destroy
    has_many :companies, through: :companies_locations
  
    validates :name, presence: true, uniqueness: { conditions: -> { with_deleted }}
  end
  