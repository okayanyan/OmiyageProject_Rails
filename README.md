# お土産口コミサービス「みやログ」

## ※[こちら](https://github.com/okayanyan/OmiyageProject)で作成したものをrailsベースで作成、改良したものです。

<br>

------

## サービスについて

------

### サービス概要

-   お土産の口コミを投稿、閲覧できるサービスです。
-   以下のことができます。
    -   ユーザー作成、編集、削除
    -   ログイン、ログアウト機能
    -   口コミの検索、閲覧
    -   口コミの投稿、編集、削除
    -   他ユーザーのフォロー
    -   投稿のお気に入り登録

### サービスへのリンク

[ポートフォリオはこちら](https://miyalog.tk/)

<br>

------

## 技術について

------

### 開発環境、使用技術

-   OS
    -   Debian 10
-   Programming Language
    -   Ruby 2.6.3
-   FW
    -   Ruby on Rails 5.2.4
        -   unicornでappサーバコンテナとwebサーバコンテナを連携
-   Webサーバ
    -   Nginx
-   DB
    -   MySQL 5.7
-   PaaS/SaaS
    -   AWS(EC2, S3, ROUTE53, ELB, VPC, ACM)
        -   HTTPS :クライアント⇨ELB
        -   HTTP   : ELB⇨EC2
    -   Freedom（フリードメイン）
-   ソース管理
    -   Git
-   Dockerコンテナ構成
    -   web
    -   app
    -   db
        -   [環境構成スクリプト群](https://github.com/okayanyan/DockerSet_RailsEnv5_2)

### 主な実装機能

-   ユーザー作成、編集、削除機能
-   ログイン・ログアウト機能
-   投稿一覧、詳細表示機能
-   投稿検索機能
-   ページネーション機能
-   投稿作成、編集、削除機能
-   画像アップロード機能
-   お気に入り登録機能