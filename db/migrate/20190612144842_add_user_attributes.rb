class AddUserAttributes < ActiveRecord::Migration[5.2]
  def change
    add_column          :users, :gender, :integer 
    change_column_null  :users, :gender, false   
    change_column_null  :users, :name, false
    change_column_null  :users, :email, false 
  end
end
