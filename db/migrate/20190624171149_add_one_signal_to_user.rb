class AddOneSignalToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :id_onesignal, :string
  end
end
