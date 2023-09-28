class CreateCompaniesPractices < ActiveRecord::Migration[7.0]
  def change
    create_table :companies_practices do |t|
      t.references :company, null: false, foreign_key: true
      t.references :practice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
