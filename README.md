# with Doggies
<img width="1000" alt="with_Doggies_Top" src="https://user-images.githubusercontent.com/121223610/228140966-9404fd00-9858-47c8-8961-66c1cc5229c0.png">
<img width="1000" alt="with_Doggies_About" src="https://user-images.githubusercontent.com/121223610/228140980-6614df75-29c1-470c-a192-c3bb695f31da.png">

## サイト概要

### ★// サイトテーマ
- 犬と一緒に利用できる場所について情報共有をするためのコミュニティサイトです。
- ドッグラン、ドッグカフェ等、会員となるユーザーが共有したいと思う良い場所を投稿します。

### ★// テーマを選んだ理由
　犬と利用できる場所の情報が集まったサイトは多くの人が必要としていると感じたからです。<br>
　犬と一緒に出かける際、ドッグランやドッグカフェ等、利用できる場所を調べるのですが、必要な情報が多く集まったサイトがあるようで無いのが現状です。いくつか情報を集めてブログとして投稿している方もいますが、それだけを見るとやはり個人の主観が強いものとなってしまいます。<br>
　私自身が犬と暮らす日常の中で、ドッグランを利用したいけど会員制だった、大型犬は利用不可だった、出かけた先で怪我をしたけどどこの病院がいいのかわからない、と感じることは少なくありません。犬を飼っている友人知人に聞いてみたところ、同じように感じている人が多くいることを知り、必要な情報を共有し合えるサイトを作ろうと決めました。1人が調べて投稿するのではなく、会員が良いと思う場所を共有し合える場にしたいと考えています。

### ★// ターゲットユーザ
- 犬と利用できる場所を知りたい人
- 自分が知っている良いと思う場所を共有したいと思っている人
- 自分が経営しているドッグカフェを知ってほしいと思っている人
- 犬を飼っていないけど、ドッグランやドッグカフェで犬と触れ合いたいと思っている人

### ★// 主な利用シーン
- 出かける先にドッグランがあるか知りたいとき
- 出かける先にドッグカフェがあるか知りたいとき
- ドッグカフェにドッグランが併設しているか知りたいとき
- 小型犬から大型犬まで利用できる場所かどうか知りたいとき
- 出かけた先で犬の体調が悪くなった時、怪我をした時に利用できる病院を知りたいとき


## 設計書
- [実装機能リスト](https://docs.google.com/spreadsheets/d/1uibf8WzyrorbvmAVGgPADHIxtlQzcdWY0-Ia8a2LICc/edit#gid=885378170)
- [テーブル定義書](https://docs.google.com/spreadsheets/d/1Vg60vlp4J8IuGgUmoPncdSRsUhZXsSVHsGsOeahPf0o/edit#gid=1442913927)
- [詳細設計書](https://docs.google.com/spreadsheets/d/116qFBjLM16b-cSfXoUtjNvBnW8o79Ya05zE9A7bcaPA/edit#gid=60403140)
- [ワイヤーフレーム](https://www.figma.com/file/4BJmmAL4gTf422EgEqxIk0/Wireframing-in-Figma?node-id=118-275&t=knUa2cimJ7flng6s-0)
- [ER図](https://user-images.githubusercontent.com/121223610/228139968-5ac22a36-5d98-4313-a392-78768b75b103.png)

## 実装機能
#### 管理者側
`[会員管理機能]` 会員の退会(論理削除)が可能<br>
`[投稿管理機能]` 不適切な投稿は削除(物理削除)が可能<br>
`[コメント管理機能]` 不適切なコメントは削除(物理削除)が可能<br>
`[検索機能]` キーワード検索：投稿施設名と都道府県名で検索が可能<br>
`[並べ替え機能]` 検索以外にも投稿と会員を探しやすくするため<br>
#### 会員側
`[会員機能]` マイページで画像/自身の投稿/ブックマークした投稿を表示（退会機能は不要と考え実装なし）<br>
`[投稿機能]` 一覧画面では投稿時のカテゴリー別でタブ表示<br>
`[検索機能]` キーワード検索：投稿施設名と都道府県名で検索が可能<br>
`[検索機能]` 複数タグ検索：チェックボックスで複数指定可能<br>
`[おすすめ機能]` 他の会員におすすめ施設を伝える<br>
`[ブックマーク機能]` ブックマーク一覧画面で確認可能<br>
`[コメント機能]` 感想や補足情報を伝える<br>
`[コメント通知機能]` コメントがあればマイページから通知を確認可能<br>
`[外部MapAPI機能]` 投稿施設の場所を表示し、Mapから施設住所を取得<br>
`[並べ替え機能]` 検索以外にも投稿を探しやすくするため<br>
#### ゲストログイン（アクセス制限なし）

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
