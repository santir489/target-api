class CreateTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :targets do |t|
      t.text        :title
      t.references  :user, foreign_key: true
      t.integer     :length
      t.timestamps
    end
  end
end
