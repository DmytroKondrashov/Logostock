class RemoveDefaultEmailUidFromClients < ActiveRecord::Migration[7.0]
  def change
    change_column_default :clients, :email, nil
    change_column_default :clients, :provider, nil
    change_column_default :clients, :uid, nil
  end
end
