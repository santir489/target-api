class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :message,    null: false
      t.text :email_from, null: false
      t.text :email_to,   null: false
      t.boolean :sent,    null: false, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
