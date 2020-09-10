# Argument_space DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|password|string|null: false|
|email|string|null: false|

### Association
- has_many :scores
- has_many :comments

## groupテーブル
|Column|Type|Options|
|------|----|-------|
|title|string||

### Association
- has_many :comments
- has_many :images
- has_one :score

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text||
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreing_key: true|

### Association
- belongs_to :user
- belongs_to :group
- has_many :images

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string||
|comment_id|integer||
|group_id|integer|

### Association
- belongs_to :comment
- belongs_to :group

## scoresテーブル
|Column|Type|Options|
|------|----|-------|
|victory|integer||
|group_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
