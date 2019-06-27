class AddIndexTitleTarget < ActiveRecord::Migration[5.2]
  def change
    add_index :targets, :title, unique: true
  end
end
