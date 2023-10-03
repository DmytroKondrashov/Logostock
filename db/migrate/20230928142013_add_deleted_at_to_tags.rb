class AddDeletedAtToTags < ActiveRecord::Migration[7.0]
  def change
    add_column :practices, :deleted_at, :datetime
    add_column :asset_classes, :deleted_at, :datetime
    add_column :job_functions, :deleted_at, :datetime
    add_column :locations, :deleted_at, :datetime
    
    add_index :practices, :deleted_at
    add_index :asset_classes, :deleted_at
    add_index :job_functions, :deleted_at
    add_index :locations, :deleted_at
  end
end
