json.comment do
  json.array! @comments do |comment|
    json.text comment.text
    json.id comment.id
    json.nickname comment.user.nickname
    json.index comment.index
    json.date time_setting(comment.created_at)
  end
end
json.anchors do
  json.array! @anchors do |anchor|
    json.anchor anchor
  end
end