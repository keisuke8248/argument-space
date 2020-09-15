class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :vote, unsigned: true, null: false, default: 1
      t.references :comment, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
