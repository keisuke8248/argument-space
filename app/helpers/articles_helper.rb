module ArticlesHelper
  def categoryArray
    ["entertainment", "general", "health", "science", "sports", "technology"]
  end

  def articleID(a)
    article = Article.where(title: a.title, url: a.url)
    return article.ids
  end
end
