class AddUserAttributes < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gender, :integer 
    change_column_null :users, :gender, false
  end
end
