class CreateCompaniesJobFunctions < ActiveRecord::Migration[7.0]
  def change
    create_table :companies_job_functions do |t|
      t.references :company, null: false, foreign_key: true
      t.references :job_function, null: false, foreign_key: true

      t.timestamps
    end
  end
end
