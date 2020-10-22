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
|article|references|foreign_key: true|
|user   |references|foreign_key: true|

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
|article_comment|references|foreign_key: true|
|user|references|foreign_key: true|
|children_user|references|foreign_key: {to_table: :users}|

### Association
- belongs_to :article_comment
- belongs_to :user

## article_comment_repliesテーブル
|Column|Type|Options|
|------|----|-------|
|parent_article_comment|references|foreign_key: {to_table: :article_comments}|
|children_article_comment|references|foreign_key: {to_table: :article_comments}|

### Association
- belongs_to: article_comment