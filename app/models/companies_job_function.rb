class CompaniesJobFunction < ApplicationRecord
    belongs_to :company, touch: true
    belongs_to :job_function
end
