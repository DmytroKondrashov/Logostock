class CompaniesPractice < ApplicationRecord
    belongs_to :company, touch: true
    belongs_to :practice
end
