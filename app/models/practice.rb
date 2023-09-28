class Practice < ApplicationRecord
    has_many :companies_practices, dependent: :destroy
    has_many :companies, through: :companies_practices

    validates :name, presence: true, uniqueness: { conditions: -> { with_deleted }}
end
