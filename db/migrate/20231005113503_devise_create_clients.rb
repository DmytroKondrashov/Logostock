# frozen_string_literal: true

class DeviseCreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""

      ## SSO
      t.string :provider, null: false, default: ""
      t.string :uid, null: false, default: ""


      t.timestamps null: false
    end

    add_index :clients, [:provider, :email], unique: true
    add_index :clients, [:provider, :uid], unique: true
  end
end
