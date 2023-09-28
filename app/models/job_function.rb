class JobFunction < ApplicationRecord
    has_many :companies_job_functions, dependent: :destroy
    has_many :companies, through: :companies_job_functions
  
    validates :name, presence: true, uniqueness: true
  end