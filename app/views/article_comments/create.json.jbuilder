if @new_comment.length == 1
  json.comment do
    json.id @new_comment.ids
    json.index @new_comment.first.index
    json.text @new_comment.first.text
    json.nickname @new_comment.first.user.nickname
    json.user_id @new_comment.first.user.id
    json.date time_setting(@new_comment.first.created_at)
  end
  json.anchors do
    json.array! @anchors[0] do |anchor|
      json.anchor anchor
    end
  end
  json.reply do
    json.reply @repliesToCurrentUser
  end
  json.userDistinction do
    json.key @userDistinction
  end
else
  json.comment do
    json.array! @new_comment do |comment|
      json.id comment.id
      json.index comment.index
      json.text comment.text
      json.nickname comment.user.nickname
      json.user_id comment.user.id
      json.date time_setting(comment.created_at)
    end
  end
  json.anchors do
    json.array! @anchors do |anchor|
      json.anchor anchor
    end
  end
  json.reply do
    json.reply @repliesToCurrentUser
  end
  json.userDistinction do
    json.key @userDistinction
  end
end

