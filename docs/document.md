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
本プロジェクトを開発しながら，記録のようなものをつけました．自分がどう考えてどのように実装したのか，軽くですがまとめています．  
分量の割に中身がないので全て読む必要はないです（後で抜粋してdocumentにまとめるつもりでした...）．



# API usage
