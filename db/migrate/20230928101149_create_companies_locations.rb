class CreateCompaniesLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :companies_locations do |t|
      t.references :company, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
