class CreateConversationsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations_users do |t|
      t.references :user,         foreign_key: true
      t.references :conversation, foreign_key: true
      t.boolean    :connected,    null: false, default: false

      t.timestamps
    end
  end
end
