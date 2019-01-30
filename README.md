# Nuxt with SSR導入時の手順
一旦テストと、PWAはなしで。

# 初期手順
terminalから、以下を実行すると、dockerにnodeをインストールした環境ができる。

```
$ docker-compose -f docker-compose.init.yml up -d
# 「builder_nuxt_1」は、container nameで、dokcer ps で確認できるので、自分の環境と合わせて。
$ docker exec -it builder_nuxt_1 sh
```

これで、dockerの中に入れるので、dockerの内部で、nuxtをinstall
```
$ yarn create nuxt-app .

# こんな感じに回答する。
> Generating Nuxt.js project in /app
? Project name app
? Project description My mind-blowing Nuxt.js project
? Use a custom server framework express
? Choose features to install Linter / Formatter, Prettier, Axios
? Use a custom UI framework none
? Use a custom test framework none
? Choose rendering mode Universal
? Author name
? Choose a package manager yarn

# install終わったら、installしたものが、localにコピーされてるはず。
# 一回dockerから出る。
$ exit
```

実際の開発をするためのコンテナを起動する。
```
$ docker-compose up -d --build
```

これで、``localhost:3000`` で、nuxtにアクセスできる。


# 開発時
毎回、コマンド打つの面倒だから、makeコマンドを利用する。

```
# こんな感じで起動できる。
$ make start

# バグったらこれ試してみる
$ make rm_node_modules
$ make restart
```

注意: 初期手順後すぐに make コマンドを利用する時は、一回下のコマンドで、立ち上がってるdockerを殺す。

```
$ docker-compose kill
$ docker-compose rm -f
```

# よく使うpackage

- 全ページで利用するCSS変数を設定する
  - https://github.com/nuxt-community/style-resources-module
- Google Analyticsの設定
  - https://github.com/nuxt-community/analytics-module
- pugとか、scss使いたい
  - https://ja.nuxtjs.org/faq/pre-processors/
  - ``yarn add pug@2.0.3 pug-plain-loader node-sass sass-loader``
- 画像の遅延読み込みをしたい
  - https://github.com/hilongjw/vue-lazyload
  - https://okadak1990.hatenablog.com/entry/2019/01/12/195327
- API叩きたい
  - https://axios.nuxtjs.org/

# エディターについて
Vue開発においては、vscodeがおすすめ！

```.vscode/settings.json
{
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    {
      "language": "vue",
      "autoFix": true
    }
  ],
  "editor.formatOnSave": true,
  "prettier.eslintIntegration": true,
  "eslint.autoFixOnSave": true
}
```

```.vscode/extensions.json
{
  "recommendations": [
    "octref.vetur",
    "esbenp.prettier-vscode",
    "eamodio.gitlens"
  ]
}
```


これをrootディレクトリに置くと、component へコードジャンプできる！

```jsconfig.json
{
  "include": ["./components/**/*"],
  "compilerOptions": {
    "module": "es2015",
    "baseUrl": ".",
    "paths": {
      "~/components/*": ["components/*"]
    }
  }
}
```
