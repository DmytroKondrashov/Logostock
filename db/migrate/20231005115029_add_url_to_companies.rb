class AddUrlToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :url, :string
  end
end