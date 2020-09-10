class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :text, null: false
      t.string :image
      t.integer :group_id, null: false

      t.timestamps
    end
  end
end
