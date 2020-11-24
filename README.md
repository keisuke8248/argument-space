# Argument-space
日々のニュースに関して議論をするためのアプリケーションです。
<img width="1363" alt="as top-page" src="https://user-images.githubusercontent.com/62201890/98080945-a1f67a00-1eb9-11eb-9a8d-914f0fe074f2.png">

# 作成した目的
昨今はtwitter,yahooニュース上でネットニュースに関する議論が多く行われていますが、それらにはいくつかの特徴があります。
- twitterでは文字数制限が厳しく、意見をかなり簡略化して書き込まれている
- yahooニュースでは返信コメントが埋もれてしまいやすく、ニュースに対する個人の意見を書く事で終わる傾向がある<br>以上の特性を理解した上で、意見を簡略化せず、ユーザー同士の意見交換に特化した掲示板が作る事ができたらという思いから本アプリを作成しました。

# URL
https://argument-space.herokuapp.com/<br>画面上部のログインボタンよりログインをしていただくとコメントを投稿できるようになります。

# テストユーザー1
メールアドレス tarou@test.com<br>パスワード 11111111

# テストユーザー2
メールアドレス jirou@test.com<br>パスワード 11111111

# 使用技術
* Ruby 2.5.1
* Ruby on Rails 5.2.4.4 
* haml&Sass
* JavaScript
* jQuery
* MySQL(ローカル環境) 5.6
* News API
* heroku


# コメント投稿機能
* コメントの自動更新
* \>>nと記載すると自動的にn番目のコメントのリンクが生成

![as１リサイズ](https://user-images.githubusercontent.com/62201890/97253997-c9fa3380-1850-11eb-94c0-b2645f51cf24.gif)


* 自動更新の際にログイン中のユーザーへの返信が含まれる場合に返信件数を通知
* 高評価、低評価ボタンでコメントを評価
* ユーザーページにて獲得した評価をグラフ化

![as解説２リサイズ](https://user-images.githubusercontent.com/62201890/97254207-3bd27d00-1851-11eb-95a8-45b094631184.gif)

# 作成していて苦労した点
「>>n」というアンカーを書き込んで投稿すると、それを「当記事のn番目のコメントの返信」として表示させるという実装に苦労をしました。<br>
これを実現するために, 「>>n」というテキストを検出するためのコードをコントローラーに書き、検出されるとarticle_comment_repliesテーブル上に コメントのid,コメント先のidを登録させるように実装をする事で コメント = n番目のコメントへの返信 というように関連づける事ができました。

```
posted_comment = ArticleComment.create(comments_params)
    length = ArticleComment.where(article_id: @article_id).length //登録されたコメントが記事に対する何番目のコメントなのか（インデックス）を変数に登録
    posted_comment.update(index: length.to_i) //インデックスを登録
    parent_id = posted_comment.id
    anchors1 = posted_comment.text.scan(/(?<=\>>)\d+/).uniq //アンカーを検出
    if anchors1[0].present?
      anchors1.each do |a|
        children = ArticleComment.find_by(article_id: params[:article_id], index: a)
        children_id = children.id
        ArticleCommentReply.create(parent_article_comment_id: parent_id,
                                   children_article_comment_id: children_id) //コメント先、投稿コメントのidをArticleCommentReplyテーブルに登録
      end
    end
```

# 今後の実装
レスポンシブル対応の実装によりスマートフォンでも快適に利用できるように改善する予定です。

# DB設計

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
