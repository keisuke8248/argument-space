class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :text, null: false
      t.integer :group_id

      t.timestamps
    end
  end
end
