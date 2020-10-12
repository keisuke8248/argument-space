json.array! @comments do |comment|
  json.text comment.text
  json.article_id comment.article_id
  json.id comment.id
  json.nickname comment.user.nickname
  json.index comment.index
  json.date time_setting(comment.created_at)
end