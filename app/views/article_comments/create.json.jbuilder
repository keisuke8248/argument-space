if @new_comment.length == 1
  json.id @new_comment.ids
  json.index @new_comment.first.index
  json.article_id @new_comment.first.article_id
  json.text @new_comment.first.text
else
  json.array! @new_comment do |comment|
    json.id comment.id
    json.index comment.index
    json.article_id comment.article_id
    json.text comment.text
  end
end