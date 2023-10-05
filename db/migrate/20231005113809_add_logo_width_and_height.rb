class AddLogoWidthAndHeight < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :logo_width, :integer
    add_column :companies, :logo_height, :integer
  end
end
