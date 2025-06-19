# lesson-1

## 課題概要

GET /movies で映画一覧のページを返す機能を実装する。

### 要件

- GET /movies で映画一覧のページを返す
- レスポンスは JSON ではなく HTML で返す
- movies テーブルにある要素を絞り込みせずすべて表示する
- 映画のタイトル・画像を表示する
- 画像については picsum.photos などを使って仮の画像を埋めても構わない

## 実装手順

### 1. Movie モデルの作成

- [ ] `app/models/movie.rb` ファイルを作成
- [ ] ApplicationRecord を継承した Movie クラスを定義
- [ ] 必要な属性：name, year, description, image_url, is_showing

### 2. MoviesController の作成

- [ ] `app/controllers/movies_controller.rb` ファイルを作成
- [ ] ApplicationController を継承した MoviesController クラスを定義
- [ ] index アクションを実装
  - [ ] Movie.all で movies テーブルの全レコードを取得
  - [ ] @movies インスタンス変数に代入

### 3. ルーティングの設定

- [ ] `config/routes.rb` を編集
- [ ] `resources :movies, only: [:index]` または `get '/movies', to: 'movies#index'` を追加

### 4. View ファイルの作成

- [ ] `app/views/movies` ディレクトリを作成
- [ ] `app/views/movies/index.html.erb` ファイルを作成
- [ ] HTML ファイルの基本構造を作成（DOCTYPE html を含む）
- [ ] movies データを表示する部分を実装
  - [ ] @movies を each でループして各映画を表示
  - [ ] 各映画の name を表示
  - [ ] 各映画の image_url を使用して img 要素で画像を表示
  - [ ] 画像が空の場合のフォールバック（picsum.photos など）の実装を検討

### 5. データベースマイグレーション実行

- [ ] `bundle exec rails db:migrate` で movies テーブルを作成（未実行の場合）

### 6. 動作確認

- [ ] サーバーを起動（`bundle exec rails server`）
- [ ] `http://localhost:3000/movies` にアクセス
- [ ] HTTP ステータス 200 が返されることを確認
- [ ] HTML が返されることを確認（DOCTYPE html が含まれる）
- [ ] 映画のタイトルと画像が表示されることを確認

### 7. テスト実行

- [ ] `bundle exec rspec spec/station01/movies_controller_spec.rb` でテストを実行
- [ ] すべてのテストが通ることを確認

## 参考情報

### movies テーブルの構造

```ruby
t.string "name", limit: 160, null: false  # 映画のタイトル
t.string "year", limit: 45                # 公開年
t.text "description"                      # 映画の説明文
t.string "image_url", limit: 150          # 映画のポスター画像URL
t.boolean "is_showing", null: false       # 上映中かどうか
```

### 必要なファイル

- `app/models/movie.rb`
- `app/controllers/movies_controller.rb`
- `app/views/movies/index.html.erb`
- `config/routes.rb`（編集）

### テスト項目（station01）

- 200 ステータスコードが返される
- HTML が返される（DOCTYPE html が含まれる）
- movies テーブルのレコード数と同じ件数のデータが表示される
- 各映画の name と image_url が含まれる

---

# lesson-2

## 課題概要

GET /admin/movies で現在登録されている movies の内容をすべて出力する管理画面機能を実装する。

### 要件

- GET /admin/movies で映画一覧の管理画面を返す
- レスポンスは JSON ではなく HTML で返す
- table タグを利用して表形式で表示する
- 絞り込みせず全件出力する
- 各カラムを出力する
- 画面上では以下の表記を使用する：
  - name → "タイトル"
  - year → "公開年"
  - description → "説明"
  - image_url → "画像"（リンクテキストで表示し、リンク先を画像の URL にする）
  - is_showing → "上映状況"（true のとき"上映中"、false のとき"上映予定"と表記）

## 実装手順

### 1. Admin 名前空間のコントローラー作成

- [ ] `app/controllers/admin` ディレクトリを作成
- [ ] `app/controllers/admin/movies_controller.rb` ファイルを作成
- [ ] ApplicationController を継承した Admin::MoviesController クラスを定義
- [ ] index アクションを実装
  - [ ] Movie.all で movies テーブルの全レコードを取得
  - [ ] @movies インスタンス変数に代入

### 2. ルーティングの設定

- [ ] `config/routes.rb` を編集
- [ ] admin 名前空間を追加
- [ ] `namespace :admin do resources :movies, only: [:index] end` を追加

### 3. View ファイルの作成

- [ ] `app/views/admin` ディレクトリを作成
- [ ] `app/views/admin/movies` ディレクトリを作成
- [ ] `app/views/admin/movies/index.html.erb` ファイルを作成
- [ ] HTML ファイルの基本構造を作成（DOCTYPE html を含む）
- [ ] table タグを使用したテーブル構造を実装
  - [ ] thead でヘッダー行を作成（タイトル、公開年、説明、画像、上映状況）
  - [ ] tbody で@movies を each ループして各映画の行を表示
  - [ ] image_url は "画像" というリンクテキストで `<a href="<%= movie.image_url %>">画像</a>` として表示
  - [ ] is_showing は三項演算子で `<%= movie.is_showing? ? "上映中" : "上映予定" %>` として表示

### 4. 動作確認

- [ ] サーバーを起動（`bundle exec rails server`）
- [ ] `http://localhost:3000/admin/movies` にアクセス
- [ ] HTTP ステータス 200 が返されることを確認
- [ ] HTML が返されることを確認（DOCTYPE html が含まれる）
- [ ] table タグで表形式になっていることを確認
- [ ] 全てのカラムが適切な表記で表示されることを確認
- [ ] image_url が "画像" リンクとして表示されることを確認
- [ ] is_showing が "上映中"/"上映予定" として表示されることを確認

### 5. テスト実行

- [ ] `bundle exec rspec spec/station02/movies_controller_spec.rb` でテストを実行
- [ ] すべてのテストが通ることを確認

## 参考情報

### 必要なファイル

- `app/controllers/admin/movies_controller.rb`
- `app/views/admin/movies/index.html.erb`
- `config/routes.rb`（編集）

### テスト項目（station02）

- 200 ステータスコードが返される
- HTML が返される（DOCTYPE html が含まれる）
- table タグが使用されている
- movies テーブルの全カラムが適切な表記で表示される
- image_url が "画像" リンクとして表示される
- is_showing が "上映中"/"上映予定" として表示される

---

# lesson-3

## 課題概要

管理画面から映画作品を登録できる機能を実装する。同じタイトルの重複登録を防ぎ、エラー時には適切なメッセージを表示する。

### 要件

- GET /admin/movies/new で movies の新規登録画面を表示する
- POST /admin/movies で新規登録処理を行う
- 一般的なフォーム送信で実装する
- 同じ映画タイトルは 2 つ登録できないようにする
- エラー時はフォームに戻し flash メッセージで表示する
- Rails の標準エラー画面を出さない（適切なエラーハンドリング）
- カラム名は日本語で表示する
- description は改行を許容する（textarea）
- is_showing はチェックボックスで受け取る
- image_url は URL として受け取る

### カラムと画面上の表記の対応

- id: ID
- name: タイトル
- year: 公開年
- description: 概要
- image_url: 画像 URL
- is_showing: 上映中
- created_at: 登録日時
- updated_at: 更新日時

## 実装手順

### 1. Movie モデルのバリデーション追加

- [ ] `app/models/movie.rb` を編集
- [ ] name カラムの一意性制約を追加（`validates :name, uniqueness: true`）
- [ ] 必要な presence バリデーションを追加
- [ ] name の長さ制限バリデーションを追加（limit: 160 に合わせる）

### 2. ルーティングの設定

- [ ] `config/routes.rb` を編集
- [ ] admin 名前空間の movies に new, create アクションを追加
- [ ] `namespace :admin do resources :movies, only: [:index, :new, :create] end`

### 3. Admin::MoviesController の拡張

- [ ] `app/controllers/admin/movies_controller.rb` を編集
- [ ] new アクションを追加
  - [ ] `@movie = Movie.new` でインスタンス変数を初期化
- [ ] create アクションを追加
  - [ ] Strong Parameters を定義（movie_params メソッド）
  - [ ] `Movie.create(movie_params)` で保存処理
  - [ ] 成功時は index にリダイレクト、flash[:notice] でメッセージ
  - [ ] 失敗時は new を再レンダリング、flash[:alert] でエラーメッセージ
  - [ ] 例外処理を追加（救済処理）

### 4. Strong Parameters の定義

- [ ] Admin::MoviesController に private メソッドを追加
- [ ] `movie_params` メソッドを定義
- [ ] 許可するパラメータ: name, year, description, image_url, is_showing

### 5. new ビューファイルの作成

- [ ] `app/views/admin/movies/new.html.erb` ファイルを作成
- [ ] フォームの基本構造を実装
  - [ ] `form_with model: [:admin, @movie]` を使用
  - [ ] name フィールド（text_field、ラベル「タイトル」）
  - [ ] year フィールド（text_field、ラベル「公開年」）
  - [ ] description フィールド（text_area、ラベル「概要」）
  - [ ] image_url フィールド（url_field、ラベル「画像 URL」）
  - [ ] is_showing フィールド（check_box、ラベル「上映中」）
  - [ ] submit ボタン
- [ ] flash メッセージ表示部分を追加
- [ ] バリデーションエラー表示部分を追加

### 6. index ビューの編集

- [ ] `app/views/admin/movies/index.html.erb` を編集
- [ ] 新規登録ページへのリンクを追加
- [ ] `link_to "新規登録", new_admin_movie_path`

### 7. エラーハンドリングの強化

- [ ] Admin::MoviesController の create アクションにエラーハンドリングを追加
- [ ] タイトル重複エラーの個別メッセージ
- [ ] 一般的な DB エラーの処理
- [ ] 原因不明のエラーの処理
- [ ] `begin-rescue-end` 文を使用

### 8. 動作確認

- [ ] サーバーを起動（`bundle exec rails server`）
- [ ] `http://localhost:3000/admin/movies` にアクセス
- [ ] 「新規登録」リンクが表示されることを確認
- [ ] `http://localhost:3000/admin/movies/new` にアクセス
- [ ] フォームが正しく表示されることを確認
- [ ] 正常なデータで登録できることを確認
- [ ] 同じタイトルで登録しようとするとエラーメッセージが表示されることを確認
- [ ] 必須項目が空の場合のエラー表示を確認

### 9. テスト実行

- [ ] `bundle exec rspec spec/station03/` でテストを実行
- [ ] すべてのテストが通ることを確認

## 参考情報

### 必要なファイル

- `app/models/movie.rb`（編集）
- `app/controllers/admin/movies_controller.rb`（編集）
- `app/views/admin/movies/new.html.erb`（新規作成）
- `app/views/admin/movies/index.html.erb`（編集）
- `config/routes.rb`（編集）

### Strong Parameters の例

```ruby
private

def movie_params
  params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
end
```

### フォームの例

```erb
<%= form_with model: [:admin, @movie], local: true do |f| %>
  <%= f.label :name, "タイトル" %>
  <%= f.text_field :name %>

  <%= f.label :is_showing, "上映中" %>
  <%= f.check_box :is_showing %>
<% end %>
```

### テスト項目（station03）

- GET /admin/movies/new が 200 ステータスで返される
- フォームが適切に表示される
- POST /admin/movies で正常に登録できる
- 同じタイトルの重複登録が防がれる
- エラー時に適切な flash メッセージが表示される
- バリデーションエラーが表示される

---

# lesson-4

## 課題概要

映画の編集機能を実装する。映画タイトルのタイピングミスなどを修正できるように、管理画面から既存の映画情報を編集・更新できる機能を追加する。

### 要件

- GET /admin/movies/:id で指定した ID の映画の編集画面を表示する
- GET /admin/movies の ID をリンクテキストにして、そのレコードに対応する編集画面に移動できるようにする
- ページを開いたとき、登録済み情報がフォームに入っている状態にする
- フォームの仕様や項目名などは登録画面と同様にする
- フォームの送信先は PUT /admin/movies/:id
- PUT /admin/movies/:id で指定した ID の映画レコードを更新する
- エラー処理など登録時のフォーム送信と同様にする
- 同じ映画タイトルの重複チェックは編集時も行う（ただし自分自身は除外）

## 実装手順

### 1. ルーティングの設定

- [ ] `config/routes.rb` を編集
- [ ] admin 名前空間の movies に edit, update アクションを追加
- [ ] `namespace :admin do resources :movies, only: [:index, :new, :create, :edit, :update] end`

### 2. Admin::MoviesController の拡張

- [ ] `app/controllers/admin/movies_controller.rb` を編集
- [ ] edit アクションを追加
  - [ ] `Movie.find(params[:id])` で対象の映画を取得
  - [ ] @movie インスタンス変数に代入
  - [ ] レコードが見つからない場合の例外処理
- [ ] update アクションを追加
  - [ ] `Movie.find(params[:id])` で対象の映画を取得
  - [ ] `@movie.update(movie_params)` で更新処理
  - [ ] 成功時は index にリダイレクト、flash[:notice] でメッセージ
  - [ ] 失敗時は edit を再レンダリング、flash[:alert] でエラーメッセージ
  - [ ] 例外処理を追加（救済処理）

### 3. Movie モデルのバリデーション調整

- [ ] `app/models/movie.rb` を編集
- [ ] name カラムの一意性制約を編集時に対応
- [ ] `validates :name, uniqueness: { scope: :id }` または編集対象を除外する仕組みを実装

### 4. edit ビューファイルの作成

- [ ] `app/views/admin/movies/edit.html.erb` ファイルを作成
- [ ] フォームの基本構造を実装（new.html.erb と同様）
  - [ ] `form_with model: [:admin, @movie]` を使用
  - [ ] name フィールド（text_field、ラベル「タイトル」、初期値設定済み）
  - [ ] year フィールド（text_field、ラベル「公開年」、初期値設定済み）
  - [ ] description フィールド（text_area、ラベル「概要」、初期値設定済み）
  - [ ] image_url フィールド（url_field、ラベル「画像 URL」、初期値設定済み）
  - [ ] is_showing フィールド（check_box、ラベル「上映中」、初期値設定済み）
  - [ ] submit ボタン（「更新」などの適切なテキスト）
- [ ] flash メッセージ表示部分を追加
- [ ] バリデーションエラー表示部分を追加

### 5. index ビューの編集

- [ ] `app/views/admin/movies/index.html.erb` を編集
- [ ] ID カラムを編集画面へのリンクに変更
- [ ] `link_to movie.id, edit_admin_movie_path(movie)` として実装
- [ ] テーブルのヘッダーにも ID カラムを追加（リンクである旨を示す）

### 6. エラーハンドリングの強化

- [ ] Admin::MoviesController の edit, update アクションにエラーハンドリングを追加
- [ ] レコードが見つからない場合の処理（ActiveRecord::RecordNotFound）
- [ ] タイトル重複エラーの個別メッセージ
- [ ] 一般的な DB エラーの処理
- [ ] 原因不明のエラーの処理
- [ ] `begin-rescue-end` 文を使用

### 7. Strong Parameters の確認

- [ ] Admin::MoviesController の movie_params メソッドを確認
- [ ] edit/update でも同じ Strong Parameters を使用
- [ ] 必要に応じて調整

### 8. 動作確認

- [ ] サーバーを起動（`bundle exec rails server`）
- [ ] `http://localhost:3000/admin/movies` にアクセス
- [ ] ID がリンクとして表示されることを確認
- [ ] ID リンクをクリックして編集画面に移動することを確認
- [ ] 編集画面で既存の情報がフォームに入っていることを確認
- [ ] 情報を変更して更新できることを確認
- [ ] 他の映画と同じタイトルに変更しようとするとエラーメッセージが表示されることを確認
- [ ] 必須項目を空にした場合のエラー表示を確認

### 9. テスト実行

- [ ] `bundle exec rspec spec/station04/` でテストを実行
- [ ] すべてのテストが通ることを確認

## 参考情報

### 必要なファイル

- `app/controllers/admin/movies_controller.rb`（編集）
- `app/views/admin/movies/edit.html.erb`（新規作成）
- `app/views/admin/movies/index.html.erb`（編集）
- `app/models/movie.rb`（編集：一意性制約の調整）
- `config/routes.rb`（編集）

### edit アクションの例

```ruby
def edit
  @movie = Movie.find(params[:id])
rescue ActiveRecord::RecordNotFound
  flash[:alert] = '指定された映画が見つかりません。'
  redirect_to admin_movies_path
end
```

### update アクションの例

```ruby
def update
  @movie = Movie.find(params[:id])
  if @movie.update(movie_params)
    flash[:notice] = '映画情報が正常に更新されました。'
    redirect_to admin_movies_path
  else
    flash[:alert] = '映画情報の更新に失敗しました。'
    render :edit, status: :bad_request
  end
rescue ActiveRecord::RecordNotFound
  flash[:alert] = '指定された映画が見つかりません。'
  redirect_to admin_movies_path
end
```

### ID リンクの例

```erb
<%= link_to movie.id, edit_admin_movie_path(movie) %>
```

### 一意性制約の調整例

```ruby
validates :name, uniqueness: { case_sensitive: false }
```

### テスト項目（station04）

- GET /admin/movies/:id が 200 ステータスで返される
- edit フォームが適切に表示される
- 既存の情報がフォームに事前入力されている
- PUT /admin/movies/:id で正常に更新できる
- 他の映画と同じタイトルへの変更が防がれる
- エラー時に適切な flash メッセージが表示される
- ID がリンクとして機能し、編集画面に遷移できる
- 存在しない ID でアクセスした場合の適切なエラーハンドリング
