---
title: "ソースコードの構成他"
author: "ss"
date: "2023-07-03"
---

# Project directory
Source Tree: 

```
$ tree -a -A -C -U -I .git -L 2
# （shortened）
.
├── .rspec
├── app
│   ├── controllers
│   │   ├── easy_api_controller.rb
│   │   ├── fb_controller.rb
│   │   └── ...
│   ├── services
│   │   └── fibonacci_calculator_service.rb
│   └── ...
├── test
│   ├── controllers
│   │   ├── fb_controller_test.rb
│   │   ├── easy_api_controller_test.rb
│   │   └── .keep
│   └── ...
├── config
│   ├── routes.rb
│   └── ...
├── spec
│   ├── spec_helper.rb
│   ├── requests
│   │   └── fbs_spec.rb
│   └── rails_helper.rb
├── docs
│   ├── image/
│   └── 001_setup.md
│   ├── 002_make-project.md
│   ├── 003_first-deploy.md
│   ├── 004_main-architecture.md
│   ├── 005_test.md
│   └── questions.md
├── README.md
├── Rakefile
├── Gemfile
├── Gemfile.lock
├── .ruby-version
├── .gitignore
├── .gitattributes
└── ...
```

### `app/controllers/easy_api_controller.rb`
サンプル用のapiのためのcontrollerです．静的な固定レスポンスを返します．

### `app/controllers/fb_controller.rb`
メインのapiを実現するcontrollerです．  
クエリ`n`に非負整数を指定すると，その数値をインデックスとしたフィボナッチ数を返すapiです．

### `app/services/fibonacci_calculator_service.rb`
引数に応じたfibonacci数を返すメソッドを，serviceオブジェクトとして分離したものです．

### `test/controllers/*`
テスト用ファイルがあります．今回用意したapiのテストスクリプトはRspecで実装しているため，このディレクトリは使用していません．

### `config/routes.rb`
アプリのルーティングを定義しています．

### `spec/requests/fbs_spec.rb`
Rspecで書いたrequests specです．今回のapiのテストを実装しています．

### `docs/*.md`
本プロジェクトを開発しながら，記録をつけました．自分がどう考えてどのように実装したのか，軽くですがまとめています．  
分量の割に中身がないので全て読む必要はないです（後で抜粋してdocumentにまとめるつもりで書いてました...）．



# API usage
[README](../README.md)に記載があります．

今回はapiのデプロイのために`Render.com`を利用しています．  無料枠のweb serviceを使用していて，15分間操作がないとインスタンスが自動でspun downします．再起動に30秒から1分ほど時間がかかるようです．

# Project Background
## なぜRailsで開発したか
本APIは`Rails`で開発して`Render.com`でデプロイを行いました．  

Rails（とRuby）は全く経験がなく，ソースを読んだことがある程度でした．  
ただ，ちょうど1dayインターンに参加したあたりからRails チュートリアルでインプットを始めていたこともあって，まさしく今がアウトプットのチャンスだと思いRaislを選んでみました．

正直Rubyの文法すら分からない状態でしたが，他言語の知識や自分なりの独学方法でなんとか形にできたと思います．  
基礎知識がない状態でもAPIの公開まで到達できた理由を整理すると，次のようになります．

- Rails チュートリアルが想像以上にビギナーズフレンドリーだった
  - 序盤はRailsの特徴的なプロジェクト構造の把握，次に各機能の把握，...と段階を踏んでいて理解しやすい構成になっている
- もちろん，アプリ開発に関わってきた経験も活きた
  - フロントエンドとバックエンドの棲み分け（と共生）の肌感覚
  - APIがどのような仕組みで動作しているのか，サーバとは何か
  - jsライブラリの`axios`でhttp通信を行う経験があったので，req, resの役割や挙動がわかっていた
- 基本的にRails チュートリアル（の第4章まで）に書いてあること以上の知識はないので，知らないことを明らかにする工夫を行った
  - （知りたいことの全体像が分かっているとき）
    - Web記事を検索→プロジェクトに反映
    - ChatGPTに全体像を伝える→個々の要素で知らない単語があったとき，Web記事を探してみる
      - ChatGPTといえど，まだ割とhullcinationがあるので，具体的な事柄は実際に調べる
  - （何が分からないのかも理解できていないとき）
    - キーワードになりそうな言葉で検索
    - ChatGPTにゴールを伝える→到達までのステップを示させて，そこを深掘りしていく
      - 具体的な用語が出てきた段階で記事検索

他言語の知識があれば，新しい言語やFWにも割とすぐに対応できるんだなと感じました（と言いつつ，今回はRailsの非常に優れた設計思想に乗っかっていただけな所感です）．  
もちろん初心者が開発したプロジェクトなので，メチャクチャに書いてある部分もあるはずです．引き続きインプットアウトプットを継続していけば精度も上げられるかなと思います．


## どんなところに気をつけたのか
今回の課題を取り組むにあたって，自分で目的設定を行いました．

- Railsのアウトプットの場にする
- Rubyの文法，Railsの思想に慣れる，理解する
- 実用的なRailsアプリの作成にも使える，Gemや構成の工夫を学ぶ
- api開発のプラクティスを学ぶ


そのために自分なりに工夫した点は次の通りです．

- 実装の前に状況整理
  - プロジェクト進行にあたって，実装から入るのではなくドキュメント化から入るようにした
    - 意思決定を残すため ←自分も後から見返して利用できる
    - 分かっていること，分かっていないことを整理するため
    - 頭の中で考えながら実装するより，書いてあることを実装したが方が確実性が上がるため
    - なぜその決定をしたのか，個人的な妥当性を説明するため
- Rspecでapiテスト（requests spec）
  - 一般的に用いられている → 汎用性があるため
  - テスティングフレームワークを利用した経験を得るため
- 事前にテスト作成
  - テスト作成の経験が乏しいため，Rails チュートリアルの流れを踏襲した形
  - controllerのエラー処理が正しく行われているかの確認でかなり役に立った
- fibonacci数の計算ロジックをServiceオブジェクトに切り分けた
  - Railsでのロジックの切り分けを体験するため
  - Rubyのclass文法を理解するため，Railsのfile - Objectに関する関係性を理解するため

勉強のアウトプット目的でRailsを選択したので，知らないことでも臆せずに挑戦してみました．



# 参考記事

## 環境構築系
- [【Ruby on Rails】Railsをバージョン指定してインストールする方法](https://zenn.dev/mame39/articles/7eebe8ada4f43c)
- [【完全版】MacでRails環境構築する手順の全て - Qiita](https://qiita.com/kodai_0122/items/56168eaec28eb7b1b93b#2-ruby%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%A8%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E9%81%A9%E7%94%A8)
- [ただMacのターミナルでRubyとRailsを最新バージョンにしたかっただけなのに。。 - Qiita](https://qiita.com/mokio/items/4377a228f89cfba183b8)
- 

## API開発系

- [Railsで超簡単API - Qiita](https://qiita.com/k-penguin-sato/items/adba7a1a1ecc3582a9c9)
- [Rails で「API を作る」を体感しよう🌊](https://zenn.dev/mochinozenn/articles/190e2e8b8f1edb)
- [Rails APIモード + Vue.jsでアプリを作成する手順 - mind.](https://learning-mind.hatenablog.com/entry/2020/12/14/215044)
- [RailsでWeb APIを作成する方法とメリット🤔💭 - Qiita](https://qiita.com/digitter/items/53f83ce50036b2773d55)
- [REST APIがエラー発生時に返すべきJSONの形（＋Railsでの実装方法） - Qiita](https://qiita.com/moritanzania/items/12ab364edea729e57df6)


## テスト系
- [【Rails】Rspecの環境構築手順をざっくりまとめてみた](https://zenn.dev/yukihaga/articles/816758ff6f0bdf)
- [Request Specを使おう - Qiita](https://qiita.com/kagesumi3m/items/10244978273ffffa9b92)
- [【Rspec入門#8】Controllerのテストの書き方（request specの書き方） | みやちゃのブログ](https://ymiyashitablog.com/rails-rspec-8/)
- [【Rails】APIテストの書き方 - Qiita](https://qiita.com/k-penguin-sato/items/defdb828bd54729272ad)
- [【入門】Rails APIのテスト手法まとめ - Qiita](https://qiita.com/KNR109/items/fe331069c4f958efbd96#get%E3%83%AA%E3%82%AF%E3%82%A8%E3%82%B9%E3%83%88%E3%81%AE%E3%83%86%E3%82%B9%E3%83%88)
- [【ユニットテスト入門】自動テストの意義とPHPでの具体的な使い方【基礎編】](https://zenn.dev/ttskch/articles/22b6d2b1209b97)
- [お前らにユニットテストの真髄を伝授する - Qiita](https://qiita.com/takutoy/items/c684f761c655d832e5d2)
- [Railsエンジニアのための実践！テストことはじめ - Qiita](https://qiita.com/yuyasat/items/8861b1b6f326b2dac14d#%E3%83%86%E3%82%B9%E3%83%88%E3%82%B1%E3%83%BC%E3%82%B9%E3%81%AF%E3%81%A9%E3%81%AE%E6%A7%98%E3%81%AB%E6%B4%97%E3%81%84%E5%87%BA%E3%81%9B%E3%81%B0%E3%81%84%E3%81%84%E3%81%8B)



## デプロイ系
- [【誰でも簡単】RailsアプリをRender.comでデプロイする手順まとめ - Qiita](https://qiita.com/koki_73/items/60b327a586129d157f38)
- [次世代Herokuと噂のRender.comで、Railsアプリをデプロイしてみる](https://zenn.dev/katsumanarisawa/articles/c9da48652f399d)



## Rails, Ruby
- [Rails のルーティング - Railsガイド](https://railsguides.jp/routing.html#%E3%83%AA%E3%82%BD%E3%83%BC%E3%82%B9%E3%83%99%E3%83%BC%E3%82%B9%E3%81%AE%E3%83%AB%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0-rails%E3%81%AE%E3%83%87%E3%83%95%E3%82%A9%E3%83%AB%E3%83%88)
- [RailsでREST API設計するときに知っておきたい集 - Qiita](https://qiita.com/yokoto/items/30e11f28942c36f17187)
- [Railsの誤解：CRUDはRESTじゃない！ - 杉風呂2.0 - A Lifelog -](https://suginoy.hatenadiary.org/entry/20120109/p1)
- [【入門】DockerでRailsのAPIモードを環境構築しHerokuへ本番反映する手順 - Qiita](https://qiita.com/KNR109/items/d7adfd7cc068c2456670)
- [Rubyにおけるintの最大値とは。エラー処理は？](http://whitelotus.whitesnow.jp/blog/?p=32)
- [RailsでのService Objectの上手な使い方 | giftee engineer blog](https://blog.giftee.dev/2023-02-20-rails-service-object/)
- [【Rails】Serviceオブジェクトとの付き合い方。 - Qiita](https://qiita.com/ren0826jam/items/6d3fa4c5dbdf1625e441)
- [Rails Service追加したらNameError: uninitialized constant-エンジニアtonブログ](https://www.tontonton.work/2022/02/rails-servicenameerror-uninitialized.html)
- [Ruby クラスの基礎知識まとめ - Qiita](https://qiita.com/nk-ty/items/654b285a7bcbd82b1cff)
- [【Ruby】attr_accessor(attr_reader, attr_writer)について調べた - Qiita](https://qiita.com/aberyotaro/items/626a88388d44802240a0)
- [Railsプロジェクトにおけるパラメータ処理](https://zenn.dev/virginia_blog/articles/1b08dc567b4059)




## Tips系
- [【 tree 】コマンド――ディレクトリをツリー状に表示する：Linux基本コマンドTips（179） - ＠IT](https://atmarkit.itmedia.co.jp/ait/articles/1802/01/news025.html)
- [ディレクトリ構成図を書くときに便利な記号 - Qiita](https://qiita.com/paty-fakename/items/c82ed27b4070feeceff6)
- [rmarkdownのYAMLヘッダ](http://cup.sakura.ne.jp/rpt2/rmd/introduction02.htm)
- [Markdownでスクショ画像をペーストする(VS Code)](https://zenn.dev/ktechb/articles/968ff79f8f9c46a26ee5)
