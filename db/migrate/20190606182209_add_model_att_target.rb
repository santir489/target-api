class AddModelAttTarget < ActiveRecord::Migration[5.2]
  def change
    add_column :targets, :topic, :integer
    add_column :targets, :latitude, :float
    add_column :targets, :longitude, :float

  end
end
