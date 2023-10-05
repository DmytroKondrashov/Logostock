class AddConstrainsToCompaniesName < ActiveRecord::Migration[7.0]
  def change
    change_column_null :companies, :name, false
    add_index :companies, :name, unique: true
  end
end
