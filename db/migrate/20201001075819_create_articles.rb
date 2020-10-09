class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.text :description
      t.string :author
      t.string :publishedAt
      t.string :urlToImage

      t.timestamps
    end
  end
end
