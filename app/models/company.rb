class Company < ApplicationRecord
    validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

    has_many :asset_classes_companies, dependent: :destroy
    has_many :companies_job_functions, dependent: :destroy
    has_many :companies_locations, dependent: :destroy
    has_many :companies_practices, dependent: :destroy

    has_many :asset_classes, through: :asset_classes_companies
    has_many :job_functions, through: :companies_job_functions
    has_many :locations, through: :companies_locations
    has_many :practices, through: :companies_practices
end
  