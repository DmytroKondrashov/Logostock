class AddUniqueIndexesToTags < ActiveRecord::Migration[7.0]
  def change
    add_index :asset_classes_companies, [:asset_class_id, :company_id], unique: true
    add_index :companies_job_functions, [:job_function_id, :company_id], unique: true
    add_index :companies_locations, [:location_id, :company_id], unique: true
    add_index :companies_practices, [:practice_id, :company_id], unique: true
  end
end
