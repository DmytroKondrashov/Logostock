class AddUniqueIndexesToTagsTables < ActiveRecord::Migration[7.0]
  def change
    add_index :job_functions, :name, unique: true
    add_index :asset_classes, :name, unique: true
    add_index :practices, :name, unique: true
    add_index :locations, :name, unique: true
  end
end
