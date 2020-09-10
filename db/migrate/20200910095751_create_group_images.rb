class CreateGroupImages < ActiveRecord::Migration[5.2]
  def change
    create_table :group_images do |t|
      t.string :image
      t.string :src
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
