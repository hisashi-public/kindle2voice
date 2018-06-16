# 事前準備
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
- シェルスクリプト実行環境(Linux / Mac)に必要なパッケージ
    - sox
    - ffmpeg
    - lame
    - python3
    - サービスアカウントキー(JSON)と環境変数 GOOGLE_APPLICATION_CREDENTIALSの設定
- python3 pip パッケージ 
    - google-cloud
- Kindle本のダウンロード、DRM解除、textファイル等への変換(Windows環境)
    - Windows 版Kindleを使って、Kindle本をPC上にダウンロードします。
    - Epubor Kindle DRM Removal　を使ってKindle本のDRMを解除します。
    - calibre E-book managementを使ってazw3形式(Kindle本の形式)のファイルを、text形式のファイル、「metadata.xml」、「cover.jpg」の３つのファイルに変換します。
    - text形式のファイル、「metadata.xml」、「cover.jpg」をシェルスクリプト実行環境にコピーしてください。
- batch.sh の実行
    - 'export GOOGLE_APPLICATION_CREDENTIALS=[path to service account key]' のようにして Googole Cloud Platformのサービスアカウントキーを設定します。
    - text形式のファイル、「metadata.xml」、「cover.jpg」を同じディレクトリに入れて'./batch.sh [Directory]'のように第一引数に指定してスクリプトを実行します。

    
