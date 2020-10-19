class Article < ApplicationRecord
  has_many :article_comments

  def self.createArticles(key)
    unless self.exists?(key)
      self.create(key)
    end
  end

end