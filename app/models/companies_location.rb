class CompaniesLocation < ApplicationRecord
    belongs_to :company, touch: true
    belongs_to :location
end
