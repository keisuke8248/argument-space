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

  def articlePath(id)
    article = Article.find(id)
    return article_article_comments_path(article.id)
  end

  def articleTitle(id)
    article = Article.find(id)
    return article.title
  end
end
