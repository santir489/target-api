class AddValidationTarget < ActiveRecord::Migration[5.2]
  def change
    change_column_null :targets, :length, false
    change_column_null :targets, :latitude, false
    change_column_null :targets, :longitude, false
    change_column_null :targets, :title, false
    change_column_null :targets, :topic, false
    change_column_null :targets, :user_id, false
  end
end

