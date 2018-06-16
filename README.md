# はじめに
このスクリプトはKindle本をGoogle Cloud Platform Cloud Text to Speech APIを使って音声合成するためのものです。
使用する場所の国の法律に従ってご使用ください。

# 事前準備

## Google Cloud Platform の準備

- Google Cloud Platform のアカウント作成
    - 下記のページから無料トライアルを選択し、無料トライアルの手続きをします。
        - [Google Cloud](https://cloud.google.com/)
- Google Cloud Platform の設定
    - Cloud TTSの有効化
        - 下記ページにログインし、左上の「ナビゲーションメニュー」から「APIとサービス」→「ライブラリ」選択します。
            - [Google Cloud Platform Console](https://console.cloud.google.com/)
        - 「Cloud Text-to-Speech API」を選択し「有効にする」を選択してAPIを有効化します。
    - サービスアカウントキーの作成
        - 下記ページにログインし、左上の「ナビゲーションメニュー」から「APIとサービス」→「認証情報」選択します。
            - [Google Cloud Platform Console](https://console.cloud.google.com/)
        - 「認証情報を作成」→「サービスアカウントキー」を選択します。
        - 役割を「Project / オーナー」、キーのタイプを「JSON」でサービスアカウントキーを作成するとPC上にJSONファイルが保存されます。

## シェルスクリプト実行環境の準備

- シェルスクリプト実行環境(Linux / Mac)に必要なパッケージ
    - sox
    - ffmpeg
    - lame
    - python3

- python3 pip パッケージ 
    - google-cloud

# Kindle本の音声合成

## Kindle本のダウンロード、DRM解除、textファイル等への変換(Windows環境)
- Windows 版Kindleを使って、Kindle本をPC上にダウンロードします。
- [Epubor Kindle DRM Removal](https://jp.epubor.com/kindle-drm%E8%A7%A3%E9%99%A4/)をインストールしてKindle本のDRMを解除します。
- [calibre E-book management](https://calibre-ebook.com/)をインストールして、azw3形式(Kindle本の形式)のファイルを、text形式のファイル、「metadata.opf」、「cover.jpg」の３つのファイルに変換します。

## batch.sh の実行
- 'export GOOGLE_APPLICATION_CREDENTIALS=[path to service account key]' のようにして Google Cloud Platformのサービスアカウントキーを設定します。
- text形式のファイル、「metadata.opf」、「cover.jpg」を同じディレクトリに入れて'./batch.sh [Directory]'のように第一引数に指定してスクリプトを実行します。
- 10分程度で、スクリプトと同じディレクトリにMP3ファイルが出来ます。
    
