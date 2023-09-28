class CreateAssetClassesCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :asset_classes_companies do |t|
      t.references :company, null: false, foreign_key: true
      t.references :asset_class, null: false, foreign_key: true

      t.timestamps
    end
  end
end
