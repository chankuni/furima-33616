# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル
| Column             | Type    | Options     |
| ------------------ | ------  | ----------- |
| nickname           | string  | null: false |
| email              | string  | null: false |
| encrypted_password | string  | null: false |
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| last_name_kata     | string  | null: false |
| first_name_kata    | string  | null: false |
| year               | integer | null: false |
| month              | integer | null: false |
| day                | integer | null: false |

### Association
- has_many :items
- has_many :cards
- has_many :shipments



## items テーブル
| Column             | Type       | Options                        |
| ------------------ | -----------| -------------------------------|
| name               | string     | null: false                    |
| image              | string     | null: false                    |
| description        | text       | null: false                    |
| category           | string     | null: false                    |
| status             | string     | null: false                    |
| charge             | integer    | null: false                    |
| area               | string     | null: false                    |
| duration           | integer    | null: false                    |
| price              | integer    | null: false                    |
| user_id            | references | null: false, foreign_key: true |

### Association
- has_one    :card
- has_one    :shipment
- belongs_to :user


## cards テーブル
| Column             | Type       | Options                        |
| ------------------ | -----------| -------------------------------|
| number             | string     | null: false                    |
| expiration         | string     | null: false                    |
| security_code      | string     | null: false                    |
| user_id            | references | null: false, foreign_key: true |
| item_id            | references | null: false, foreign_key: true |


### Association
- has_one    :shipment
- belongs_to :user
- belongs_to :item



## shipments テーブル
| Column             | Type       | Options                        |
| ------------------ | -----------| -------------------------------|
| postal_code        | string     | null: false                    |
| prefectures        | text       | null: false                    |
| municipality       | text       | null: false                    |
| address            | text       | null: false                    |
| building           | text       |                                |
| tel                | text       | null: false                    |
| user_id            | references | null: false, foreign_key: true |
| item_id            | references | null: false, foreign_key: true |
| card_id            | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- belongs_to :item
- belongs_to :card