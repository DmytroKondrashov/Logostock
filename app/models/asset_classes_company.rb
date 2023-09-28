class AssetClassesCompany < ApplicationRecord
    belongs_to :company, touch: true
    belongs_to :asset_class
end
  