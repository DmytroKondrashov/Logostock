class CsvUploaderFilenameNullFalse < ActiveRecord::Migration[7.0]
  def change
    CsvUpload.destroy_all
    change_column_null :csv_uploads, :csv_filename, false
  end
end
