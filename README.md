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
- 打刻のしやすさ：submitをクリックするだけで完了する
- 9時、12時、18時に、勤務中ページにコメントを表示：休憩時間、勤務時間をわかりやすくした
- ActionCableを用いて、コメントを即時表示にした
- 管理職だけが、従業員に対してコメントすることができる

# 使用技術(開発環境)
Rails 6.0.0 mysql utf8
# 課題や今後実装したい機能
- 賃金の計算が時間単位になっているので、分単位で計算できるようにする
- 賃金の表示をわかりやすく：料金を,で区切る
- 月給表示機能：月の合計賃金の表示
- 現状では一日一回の勤務のみに対応、日に複数回の勤務や、日にちを跨いだ勤務ができない
- 22時から５時までは賃金25％増の夜間勤務の計算（賃金の割増は重複する）
- 休日出勤は賃金35％増の計算（週1日、月4日は法定休日となる）
- 時間外労働は賃金25%増計算(1日８時間、週40時間以上は時間外労働となる)
- カウントダウン表示機能：休憩の残り時間を表示する
- excelなどのファイルに統計資料としてダウンロードできる
- カレンダーアプリとの連携

# DB設計

## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| username | string | null: false |
| email    | string | null: false |
| password | string | null: false |


### Association

- has_many :jikans
- has_many :wages
- has_many :comments

## jikans テーブル

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
| jikan    | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :jikan

## comments テーブル
| Column | Type       | Options           |
| ------ | ---------- | ----------------- |
| text   | text       | null: false       |
| user   | references | foreign_key: true |
| jikan  | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :jikan
