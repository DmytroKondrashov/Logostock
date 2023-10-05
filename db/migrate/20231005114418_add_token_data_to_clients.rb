class AddTokenDataToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :token, :string
    add_column :clients, :refresh_token, :string
    add_column :clients, :token_expires_at, :integer
  end
end
