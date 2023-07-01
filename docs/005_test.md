---
title: 'ユニットテストを実装する'
author: 'ss'
date: '2023-07-01'
---

# ユニットテストを実装したい

## けど，rails でどうやって実装するんだろう！

rails も api テストも初心者なので，どこから手をつけて良いか不明です．

テスト駆動型開発（TDD）という考え方もあるようですが，細かな知識もないので今回は素直に [Rails チュートリアル](https://railstutorial.jp/chapters/static_pages?version=7.0#sec-our_first_test)で紹介されているテスト方法のお作法を参考にしてみます．

加えて，railsアプリのテストにはRSpecというテスティングフレームワークを使うのが一般的のようです．  
今回テストの規模は小さいですが，今後の練習も兼ねてRSpecを利用してみます．

### 事前にテストを作成することのメリット・デメリット
メリット

- テスト漏れが重大なインシデントとなるロジックや，他のロジックと関連しているものに対して有効
- 全テストケース合格 ≒ 実装完了

デメリット

- 仕様（in/out）が変わった場合，テストが無駄になる

今回は要求仕様が決まっていて変化しないので，事前にテストを作成する方針でいきます．

### RSpecについて
Rspecは，Rubyにおけるテスティングフレームワークです．  
ドキュメント記述のようにテストケースを作成することができるとのこと．ワクドキ

---

## ユニットテストの流れ

基本的に，「開発＝テストケース全合格」の流れで開発を行います．  
テストケースを充足していれば，すなわち実装完了とします．（このやり方が正しいのかは分からない...）

1. path `/fb`を作成する
    - controller, routes
1. `/fb`に対するテストを作成する
1. そのテストを実行し，エラーを確認する
1. そのテストを満たすようにコーディングを行う
1. テストがオールグリーンになるまで{コーディング→テスト}を繰り返す

---

# テストケースを作成する！！
実装の前にテストケースを作成します．このテストをクリアしたら実装完了，と言うためには，網羅的にテストケースを用意する必要があるか...が今回はテスト対象が1ルートだけなので，恐らく簡単（？）

## テストケース

テストケースを考えます．  
といっても今回は，パラメータの値が正しい場合と正しくない場合の2種類のみですが！

| パラメータ`n`の値 | status・json |
| - | - |
| ?n=10 | 200・{ "result": 50 } |
| ?n=0 | 200・{ "result": 0 } |
| ?n=1 | 200・{ "result": 1 } |
| ?n=1.5 | 400・{ "status": 400, "errors": <br />[{"type": "invalid-parameter", "title": "パラメータの値が不正です"}] } |
| ?n=(指定なし) | 400・{ "status": 400, "errors": <br />[{"type": "invalid-parameter", "title": "パラメータの値が不正です"}] } |
| /fb (?n= が無し) | 400・{ "status": 400, "errors": <br />[{"type": "invalid-parameter", "title": "パラメータの値が不正です"}] } |
| ?n="string" | 400・{ "status": 400, "errors": <br />[{"type": "invalid-parameter", "title": "パラメータの値が不正です"}] } |
| | |


フィボナッチ数はn=0,1の時の値が定義されているため，検証を行います（境界値分析っぽく）．  
また，最大数は考慮しません（rubyは整数型の最大幅が無限...固定長の長さを超えるとメモリ依存の無限多倍長整数に拡張されるとのこと．wow）

"errors"を配列にしているので，エラーの種類に応じて複数のエラーを渡せます．  今回は時間があったら作り込みましょう（この文章が残っているということは，つまりそういうこと）


# API（ユニットテスト）を実装する！！

ユニットテストの流れを参考にして，早速コーディングします！

## Rspecのインストール
最初にRspecをプロジェクトにインストールしておきます．

Rspecの準備に関して詳しい手順や説明を知りたい方は，以下の記事がおすすめです！

[【Rails】Rspecの環境構築手順をざっくりまとめてみた](https://zenn.dev/yukihaga/articles/816758ff6f0bdf)

### gemの追加
`rspec-rails`をGemfileに加えます．

```Gemfile: /Gemfile
group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails'  # バージョン未指定で警告が出なかったので，一旦このままにする
end
```

```
$ budle install
```

Rspecの基本設定ファイルを生成します．

```
$ rails g rspec:install
      create  .rspec
      create  spec
      create  spec/spec_helper.rb
      create  spec/rails_helper.rb
```

テストの実行結果表示を読みやすくするための設定を記述します．
```.rspec: /.rspec
...
--format documentation
```

`spec/support`配下のファイルを読み込むために，以下の一文をコメントアウト解除します．
```ruby: spec/support
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }
```


## Controllerの生成
`fb`controllerを`generate`して，apiのエンドポイント`/fb`を作成します．同時にルーティングも対応させます．

```
$ rails generate controller fb
      create  app/controllers/fb_controller.rb
      invoke  test_unit
      create    test/controllers/fb_controller_test.rb
```

```diff ruby: config/routes.rb
Rails.application.routes.draw do
  get 'easy_api', to: 'easy_api#index'
+ get 'fb', to: 'fb#index'

  root 'application#hello'
end
```

続いて，`fb` controllerにaction `index` を追加します．  
`index`はGETメソッドに対応します．

この後テストコードを書くので，中身は適当な記述をしておきます．


```ruby:app/controllers/easy_api_controller.rb
class FbController < ApplicationController
  def index
    render json: { message: "init" }
  end
end
```

さて，ここまででルート作成が完了しました．ローカルで起動して確認します．

![](image/2023-07-01-23-48-28.png)