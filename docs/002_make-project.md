---
title: "railsプロジェクトの作成"
author: "ss"
date: "2023-06-27"
---

# Railsプロジェクトを作成する
## `rails new`
ここからrails appの骨格を作成していきます．

前回インストールしたrailsのバージョンが`rails 7.0.5`だったので，このバージョンを指定してrailsアプリケーションを作成します．

なお，今回はapiモードでプロジェクトを作成します．  
`--skip-bundle`は**Rails チュートリアル**の指示に倣っています．プロジェクトを作るのを優先して，不要なgemのインストールは後にするためです．

```
$ rails _7.0.4_ new . --api --skip-bundle
```

成功し，一気にファイルが作成されました．  
現状，ディレクトリ構造はこのようになっています．

```
# .git/ 以外をツリー表示
$ tree -a -A -C -U -I .git -L 2

.
├── app
│   ├── mailers
│   ├── models
│   ├── jobs
│   ├── controllers
│   ├── views
│   └── channels
├── .ruby-version
├── test
│   ├── mailers
│   ├── integration
│   ├── models
│   ├── fixtures
│   ├── test_helper.rb
│   ├── controllers
│   └── channels
├── bin
│   ├── rake
│   ├── setup
│   └── rails
├── config
│   ├── routes.rb
│   ├── locales
│   ├── cable.yml
│   ├── environments
│   ├── master.key
│   ├── environment.rb
│   ├── storage.yml
│   ├── application.rb
│   ├── puma.rb
│   ├── credentials.yml.enc
│   ├── database.yml
│   ├── boot.rb
│   └── initializers
├── config.ru
├── docs
│   ├── 002_make-project.md
│   ├── image
│   └── 001_setup.md
├── storage
│   └── .keep
├── README.md
├── Rakefile
├── public
│   └── robots.txt
├── .gitignore
├── .gitattributes
├── lib
│   └── tasks
├── db
│   └── seeds.rb
├── Gemfile
├── log
│   └── .keep
├── tmp
│   ├── pids
│   ├── cache
│   ├── .keep
│   └── storage
└── vendor
    └── .keep

32 directories, 29 files
```

まあ，何のことやらですね．

## `bundle install`
次に`gem`のインストールを行います．

`Gemfile`の`gem "rails", "~> 7.0.5"`を`gem "rails", "7.0.5"`に置き換え，railsのバージョンを保ちます．

`gem`をインストールします．

```
$ bundle -v
Bundler versions 2.4.10

# rails チュートリアルに倣い，魔法の呪文を唱える
$ bundle _2.4.10_ config set --local without 'production'

$ bundle _2.4.10_ install
```

一旦ここでgitにpushしました．