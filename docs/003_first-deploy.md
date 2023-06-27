---
title: "初期デプロイと簡単なAPI作成"
author: "ss"
date: "2023-06-27"
---

# さっそくデプロイして動作確認してみよう！
## railsの動作確認
さて，ここまでで

- rails 環境構築
- rails プロジェクトの作成

まで完了しました！

初めてのrailsプロジェクトなので，ワクワクが止まりません！！  
部屋も暑くなってきて，Macのファンの音も止まりません！！

...

熱気が凄いので，とりあえず窓を開けてきます．

---

窓も開いて涼しくなる準備が整ったところで，さっそくrailsアプリを起動してみます．

```
$ rails server
```
どうかな...？

やりました！無事に起動することができました．  
これが人生初のrailsです．．．感動で涙が出てきそうです．  
汗も止まりません（窓開けたのになあ）

![first rails](image/2023-06-27-16-16-28.png)
*人生初のrailsアプリ起動画面*

起動できたら，少しいじってみたくなるのがヒトのサガ...

```diff ruby:app/controllers/application_controller.rb
class ApplicationController < ActionController::API
+  def hello
+    render html: "hello world!"
+  end
end
```

```diff ruby:config/routes.rb
Rails.application.routes.draw do
+  root 'application#hello'
end
```

![](image/2023-06-27-16-46-07.png)
*画面が変わりました！*

アプリが正しく動作することが確認できたので，この時点でデプロイしてみます．

冒頭でエラーに出くわすか，後で出くわすか...  
最後の最後で困ってしまうのも問題なので，悩むなら今のうちに，のスタンスでいきましょう．

## Render.comにデプロイ
アプリをデプロイします．

使用するのは[`Render.com`](https://dashboard.render.com/)．次世代のherokuと噂されているとの噂です（？？）

流れはこちらの記事を参考にさせていただきました．  
[【誰でも簡単】RailsアプリをRender.comでデプロイする手順まとめ - Qiita](https://qiita.com/koki_73/items/60b327a586129d157f38#web%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E4%BD%9C%E6%88%90)

[第1章 ゼロからデプロイまで - Railsチュートリアル](https://railstutorial.jp/chapters/beginning?version=7.0#cha-beginning)

ここで注意です．`bundle lock`なる設定を行っていなかったため，デプロイでコケました．  
エラーログを見ると，macユーザーは最後の部分が`x86_64-darwin-21`みたいになるのかな？

ログに従って，次のようにして再度デプロイをします．

```
$ bundle lock --add-platform x86_64-linux
```
