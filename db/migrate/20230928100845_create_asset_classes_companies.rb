class CreateAssetClassesCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :asset_classes_companies do |t|

      t.timestamps
    end
  end
end
