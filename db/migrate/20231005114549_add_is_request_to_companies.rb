class AddIsRequestToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :is_request, :boolean, :default => false
    add_column :companies, :client_id, :bigint
  end
end
