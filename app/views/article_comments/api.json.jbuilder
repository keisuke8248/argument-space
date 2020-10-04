json.array! @comments do |comment|
  json.text comment.text
  json.article_id comment.article_id
  json.id comment.id
end