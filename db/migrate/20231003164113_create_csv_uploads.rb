class CreateCsvUploads < ActiveRecord::Migration[7.0]
  def change
    create_table :csv_uploads do |t|
      t.string :csv_filename, null: false
      t.jsonb :csv_content, null: false
      t.jsonb :companies_applied
      t.jsonb :companies_failed
      t.jsonb :companies_discarded
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
