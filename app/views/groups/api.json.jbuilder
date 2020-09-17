json.array! @comments do |comment|
  json.text comment.text
  json.nickname comment.nickname
  json.date comment.created_at.strftime("%Y年%m月%d日 %H時%M分")
end