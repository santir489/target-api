class CreateConversationsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations_users do |t|
      t.references :user,         foreign_key: true, null: false
      t.references :conversation, foreign_key: true, null: false
      t.boolean    :connected,    null: false, default: false

      t.timestamps
    end
  end
end
