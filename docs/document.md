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

rails（とRuby）は全く経験がなく，ソースを読んだことがある程度でした．  
ただ，ちょうど1dayインターンに参加したあたりからRails チュートリアルでインプットを始めていたこともあって，まさしく今がアウトプットのチャンスだと思いRaislを選んでみました．

正直Rubyの文法すら分からない状態でしたが，他言語の知識や自分なりの独学方法でなんとか形にできたと思います．  
基礎知識がない状態でもAPIの公開まで到達できた理由を整理すると，次のようになります．

- Rails チュートリアルが想像以上にビギナーフレンドリーだった
  - 序盤はRailsの特徴的なプロジェクト構造の把握，次に各機能の把握，...と段階を踏んでいて理解しやすい構成になっている
- もちろん，アプリ開発に関わってきた経験も活きた
  - フロントエンドとバックエンドの棲み分け（と共生）
  - APIがどのような仕組みで動作しているのか，サーバとは何か
  - jsライブラリの`axios`でhttp通信を行う経験があったので，req, resの役割や挙動がわかっていた
- 基本的にRails チュートリアル（の第4章まで）に書いてあること以上の知識はないので，知らないことを明らかにする工夫を行った
  - （知りたいことの全体像が分かっているとき）
    - Web記事を検索→プロジェクトに反映
    - ChatGPTに全体像を伝える→個々の要素で知らない単語があったとき，Web記事を探してみる
      - ChatGPTといえど，まだ割とハルシネーションがあるので，詳細な事柄は実際に調べました
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
- 実際にRailsアプリを作成する際にも使える，Gemや構成の工夫を学ぶ
- api開発のプラクティスを学ぶ


そのために自分なりに工夫した点は次の通りです．

- 実装の前に状況整理
  - プロジェクト進行にあたって，実装から入るのではなくドキュメント化から入るようにしました
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