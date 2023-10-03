class SwitchCsvUploaderToJsonbFormat < ActiveRecord::Migration[7.0]
  def up
    change_column :csv_uploads, :csv_content,         :text, null: false
    change_column :csv_uploads, :companies_applied,   :jsonb
    change_column :csv_uploads, :companies_failed,    :jsonb
    change_column :csv_uploads, :companies_discarded, :jsonb
  end

  def down
    change_column :csv_uploads, :csv_content,         :json
    change_column :csv_uploads, :companies_applied,   :json
    change_column :csv_uploads, :companies_failed,    :json
    change_column :csv_uploads, :companies_discarded, :json
  end
end
