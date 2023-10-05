class AddDefaultsToCsvUpload < ActiveRecord::Migration[7.0]
  def change
    change_column :csv_uploads, :companies_applied, :jsonb, default: "{}", null: false
    change_column :csv_uploads, :companies_failed, :jsonb, default: "{}", null: false
    change_column :csv_uploads, :companies_discarded, :jsonb, default: "{}", null: false
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
