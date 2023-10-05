class CreateUserActions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_actions do |t|
      t.string :activity, null: false
      t.string :email, null: false
      t.string :url, null: false
      t.integer :company_ids, array: true, default: []

      t.timestamps
    end
  end
end
