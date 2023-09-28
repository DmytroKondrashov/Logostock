class AssetClass < ApplicationRecord
    has_many :asset_classes_companies, dependent: :destroy
    has_many :companies, through: :asset_classes_companies
  
    validates :name, presence: true, uniqueness: { conditions: -> { with_deleted }}
  end