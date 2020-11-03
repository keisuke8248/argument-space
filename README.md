# Usage
*コメントの自動更新
*>>nと記載すると自動的にn番目のコメントのリンクが生成
![as１リサイズ](https://user-images.githubusercontent.com/62201890/97253997-c9fa3380-1850-11eb-94c0-b2645f51cf24.gif)

*自動更新の際にログイン中のユーザーへの返信が含まれる場合に返信件数を通知し
*高評価、低評価ボタンでコメントを評価
*ユーザーページにて獲得した評価をグラフ化
![as解説２リサイズ](https://user-images.githubusercontent.com/62201890/97254207-3bd27d00-1851-11eb-95a8-45b094631184.gif)

# Argument_space DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|password|string|null: false|
|email|string|null: false|

### Association
- has_many :article_comments
- has_many :evaluations

## articlesテーブル
|Column     |Type|Options    |
|-----------|----|-----------|
|title      |text|null: false|
|url        |text|null: false|
|description|text|           |
|author     |text|           |
|publidhedAt|text|           |
|urlToImage |text|           |

### Association
- has_many :article_comments

## article_commentsテーブル
|Column |Type      |Options          |
|-------|----------|-----------------|
|text   |string    |null: false      |
|index  |integer   |                 |
|article_id|references|foreign_key: true|
|user_id   |references|foreign_key: true|

### Association
- belongs_to :article
- belongs_to :user
- has_many :evaluations
- has_many :article_comment_replies

## evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|good|integer|null: false, default: 0|
|bad|integer|null: false, default: 0|
|article_comment_id|references|foreign_key: true|
|user_id|references|foreign_key: true|
|children_user_id|references|foreign_key: {to_table: :users}|

### Association
- belongs_to :article_comment
- belongs_to :user

## article_comment_repliesテーブル
|Column|Type|Options|
|------|----|-------|
|parent_article_comment_id|references|foreign_key: {to_table: :article_comments}|
|children_article_comment_id|references|foreign_key: {to_table: :article_comments}|

### Association
- belongs_to: article_comment
