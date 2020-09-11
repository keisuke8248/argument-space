class CreateCommentImages < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_images do |t|
      t.string :src
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
