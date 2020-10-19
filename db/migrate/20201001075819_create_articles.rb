class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.text :title, null: false
      t.text :url, null: false
      t.text :description
      t.text :author
      t.text :publishedAt
      t.text :urlToImage

      t.timestamps
    end
  end
end
