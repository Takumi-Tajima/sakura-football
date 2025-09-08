# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要
Sakura Footballは、Rails 8.0.2で構築されたWebアプリケーションや。

## 開発コマンド

### サーバー起動
```bash
bin/dev  # Foremanを使って開発サーバー、JavaScript、CSSのビルドを同時起動
```

### 依存関係のインストール
```bash
bundle install        # Ruby gems
yarn install         # JavaScript packages
```

### データベース
```bash
bin/rails db:create  # データベース作成
bin/rails db:migrate # マイグレーション実行
bin/rails db:seed    # シードデータ投入
```

### アセットのビルド
```bash
yarn build          # JavaScriptをビルド
yarn build:css      # CSSをビルド（Sass → CSS → Autoprefixer）
```

### コード品質チェック
```bash
bin/rubocop         # Rubocopでコードスタイルチェック
```

## アーキテクチャ

### 技術スタック
- **フレームワーク**: Rails 8.0.2
- **データベース**: PostgreSQL
- **CSS**: Bootstrap 5（Sass経由）
- **JavaScript**: ESBuild + Stimulus + Turbo
- **コードスタイル**: rubocop-rails-omakase

### フロントエンドビルド
- JavaScriptは`esbuild`でESModuleとしてバンドル
- CSSは`sass` → `autoprefixer`のパイプライン
- 開発時は`bin/dev`で自動リビルド

### 重要な設計方針
- コントローラーアクションは標準の7つ（index, show, new, create, edit, update, destroy）のみ
- ビジネスロジックはモデルに配置
- 空文字列はデータベースに保存しない設計を基本とする