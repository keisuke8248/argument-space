module ArticlesHelper
  def categoryArray
    ["entertainment", "general", "health", "science", "sports", "technology"]
  end

  def categoryArrayjp
    ["エンタメ", "一般", "健康", "科学", "スポーツ", "テクノロジー"]
  end

  def articleID(a)
    article = Article.where(title: a.title, url: a.url)
    return article.ids
  end

  def article_comment(id)
    comments = ArticleComment.where(article_id: id)
    case comments
    when nil
      return "0"
    else
      return comments.length
    end
  end

end
