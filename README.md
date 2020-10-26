# Usage
![6mVppzLbYWfhQ934boSR1603734465-1603734502](https://user-images.githubusercontent.com/62201890/97208996-22a0e080-17ff-11eb-8836-6a3621113470.gif)

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
