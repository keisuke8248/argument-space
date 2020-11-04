module ApplicationHelper

  def time_setting(date)
    d = %w(日 月 火 水 木 金 土)[date.wday]
    return date.strftime("%Y/%m/%d/#{d} %H:%M:%S")
  end

  def counting_evaluation(comment_id, key)
    evaluation = Evaluation.where(article_comment_id: comment_id)
    case key
    when "good"
      return evaluation.where(good: 1, bad: 0).length
    when "bad"
      return evaluation.where(good: 0, bad: 1).length
    end
  end

  def articleTitle(id)
    article = Article.find(id)
    return article.title
  end

  def articlePath(id)
    article = Article.find(id)
    return article_article_comments_path(article.id)
  end

end
