# アプリ名 
working-for-happy
# 概要(このアプリでできることを書いて下さい)
打刻機能：労働時間を視覚化する
賃金計算機能：労働の対価を視覚化する
残業時間申告機能：残業をするためには、上司と労働者の同意を必要。何のために残業が必要なのかを明確にすることで業務量の適正化に役立つ

# 本番環境(デプロイ先 テストアカウント＆ID)

# 制作背景(意図)
勤怠管理アプリとして、使いやすく、打刻がしやすいことを重視
| 解決したい課題     | なぜその課題解決が必要なのか       | 課題を解決する実装の内容 |
| ---------------- | ----------------------------- | -------------------- |
| 不必要な残業をなくす | 業務の効率化と労働者の健康維持のため| 勤務時間を記録する機能、残業目的の明確化 |
| 労働の対価を視覚化する | 労働者のモチベーションアップと最低賃金法違反を防ぐ  | 賃金計算機能 |

# DEMO(gifで動画や写真を貼って、ビューのイメージを掴んでもらいます)

# 工夫したポイント
devise導入後、Emailではなくusernameを用いたログイン機能を実装
# 使用技術(開発環境)
Rails 6.0.0 mysql utf8
# 課題や今後実装したい機能
- 打刻機能
- 賃金表示機能
- コメント機能

# DB設計

## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| username | string | null: false |

### Association

- has_many :times
- has_many :wages
- has_many :comments

## times テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ----------------- |
| start_time | integer    | null: false       |
| user       | references | foreign_key: true |

### Association

- belongs_to :user
- has_one    :wage
- has_many   :comments

## wages テーブル

| Column   | Type       | Options           |
| -------- | ---------- | ----------------- |
| end_time | integer    | null: false       |
| paying   | integer    | null: false       |
| user     | references | foreign_key: true |

### Association

- belongs_to :user
- has_one    :time

## comments テーブル
| Column | Type       | Options           |
| ------ | ---------- | ----------------- |
| text   | text       | null: false       |
| user   | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :time
