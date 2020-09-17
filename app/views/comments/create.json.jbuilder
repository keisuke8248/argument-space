json.text @comment.text
json.nickname @comment.user.nickname
json.date @comment.created_at.strftime("%Y年%m月%d日 %H時%M分")
json.id @comment.id
json.user_id @comment.user.id