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

---

# lesson-5

## 課題概要

映画の削除機能を実装する。上映が終了した映画を管理画面から完全に削除できるようにし、データベースからレコードを物理的に削除する機能を追加する。

### 要件

- 編集画面の下部に削除ボタンを追加する
- 削除ボタンを押すと確認ダイアログが表示される
- Rails の `data-confirm` を利用して確認ダイアログを実装する
- 確認ダイアログで OK を選択すると `DELETE /admin/movies/:id` が送信される
- DELETE /admin/movies/:id で指定した ID の映画レコードを物理削除する
- 削除成功後は映画一覧画面に遷移し、flash メッセージで削除完了を通知する
- エラー時には適切なエラーハンドリングを行う

## 実装手順

### 1. ルーティングの設定

- [ ] `config/routes.rb` を編集
- [ ] admin 名前空間の movies に destroy アクションを追加
- [ ] `namespace :admin do resources :movies, only: [:index, :new, :create, :edit, :update, :destroy] end`

#### 🔍 **初学者向け詳細説明**

ルーティングとは「どの URL にアクセスしたら、どのコントローラーのどのメソッドが動くか」を決める設定です。
`destroy` アクションを追加することで、DELETE リクエストを受け取れるようになります。

### 2. Admin::MoviesController の拡張

- [ ] `app/controllers/admin/movies_controller.rb` を編集
- [ ] destroy アクションを追加
  - [ ] `Movie.find(params[:id])` で削除対象の映画を取得
  - [ ] `@movie.destroy` で物理削除を実行
  - [ ] 成功時は index にリダイレクト、flash[:notice] でメッセージ
  - [ ] 例外処理を追加（レコードが見つからない場合など）

#### 🔍 **初学者向け詳細説明**

- `find(params[:id])`: URL の `:id` 部分から映画を探す
- `destroy`: データベースから完全に削除する（物理削除）
- `flash[:notice]`: ユーザーに「削除しました」と伝えるメッセージ

### 3. edit ビューファイルの編集

- [ ] `app/views/admin/movies/edit.html.erb` を編集
- [ ] 既存の更新フォームの下に削除ボタンを追加
- [ ] `link_to` で削除ボタンを作成
  - [ ] URL: `admin_movie_path(@movie)`
  - [ ] HTTP メソッド: `DELETE`
  - [ ] `data-confirm` オプションで確認ダイアログを設定
  - [ ] ボタンのスタイリング（色を赤系にして危険なアクションであることを示す）

#### 🔍 **初学者向け詳細説明**

- `link_to`: リンクやボタンを作る Rails のヘルパーメソッド
- `method: :delete`: このリンクが DELETE リクエストを送ることを指定
- `data-confirm`: クリック時に確認ダイアログを表示する機能

### 4. 削除ボタンの実装詳細

- [ ] 削除ボタンのテキストを「削除」に設定
- [ ] 確認ダイアログのメッセージを適切に設定
  - [ ] 例：「この映画を削除しますか？削除すると元に戻せません。」
- [ ] ボタンの見た目を危険なアクションらしく設定
  - [ ] 背景色を赤系にする
  - [ ] テキスト色を白にする
  - [ ] 他のボタンと区別できるようにする

#### 🔍 **初学者向け詳細説明**

削除は取り消せない危険な操作なので、ユーザーが間違えないよう以下の工夫をします：

1. **確認ダイアログ**: 本当に削除するか確認
2. **赤色**: 危険を表す色で注意を促す
3. **明確なメッセージ**: 削除すると元に戻せないことを伝える

### 5. エラーハンドリングの実装

- [ ] Admin::MoviesController の destroy アクションにエラーハンドリングを追加
- [ ] レコードが見つからない場合の処理（ActiveRecord::RecordNotFound）
- [ ] 削除に失敗した場合の処理
- [ ] 一般的な例外の処理
- [ ] `begin-rescue-end` 文を使用

#### 🔍 **初学者向け詳細説明**

エラーハンドリングとは「何か問題が起きた時の対処法」を事前に決めておくことです。
例：存在しない映画を削除しようとした場合、エラー画面ではなく適切なメッセージを表示する

### 6. Flash メッセージの設定

- [ ] 削除成功時のメッセージを設定
  - [ ] `flash[:notice] = '映画が正常に削除されました。'`
- [ ] エラー時のメッセージを設定
  - [ ] `flash[:alert] = '映画の削除に失敗しました。'`
  - [ ] `flash[:alert] = '指定された映画が見つかりません。'`

#### 🔍 **初学者向け詳細説明**

Flash メッセージは、ユーザーに操作の結果を伝える仕組みです。

- 成功時: 緑色で「削除しました」
- 失敗時: 赤色で「削除できませんでした」

### 7. JavaScript の動作確認

- [ ] `data-confirm` が正しく動作することを確認
- [ ] 確認ダイアログで「キャンセル」を選んだ場合、削除されないことを確認
- [ ] 確認ダイアログで「OK」を選んだ場合、削除が実行されることを確認

#### 🔍 **初学者向け詳細説明**

`data-confirm` は Rails が提供する便利な機能で、JavaScript が自動的に確認ダイアログを表示してくれます。
特別な JavaScript コードを書く必要はありません！

### 8. 動作確認

- [ ] サーバーを起動（`bundle exec rails server`）
- [ ] `http://localhost:3000/admin/movies` にアクセス
- [ ] 映画を一つ作成する（テスト用）
- [ ] その映画の編集画面に移動
- [ ] 削除ボタンが表示されることを確認
- [ ] 削除ボタンをクリックして確認ダイアログが表示されることを確認
- [ ] 「キャンセル」を選んで削除されないことを確認
- [ ] 「OK」を選んで削除が実行されることを確認
- [ ] 削除後、一覧画面に戻り flash メッセージが表示されることを確認
- [ ] 削除した映画が一覧から消えていることを確認

#### 🔍 **初学者向け詳細説明**

動作確認は「作った機能が正しく動くか」をチェックする重要な作業です。
実際にボタンを押してみて、期待通りの動作をするか確認しましょう。

### 9. エッジケースのテスト

- [ ] 存在しない ID で削除を試行する
  - [ ] URL を直接入力：`http://localhost:3000/admin/movies/999/edit`
  - [ ] 削除ボタンをクリック
  - [ ] 適切なエラーメッセージが表示されることを確認
- [ ] 同じ映画を連続で削除しようとする
  - [ ] 2 回目はエラーになることを確認

#### 🔍 **初学者向け詳細説明**

エッジケースとは「普通ではない使い方」や「予期しない操作」のことです。
悪意のあるユーザーや、間違った操作をするユーザーに対しても適切に対応できるかテストします。

### 10. テスト実行

- [ ] `bundle exec rspec spec/station05/` でテストを実行
- [ ] すべてのテストが通ることを確認

## 参考情報

### 必要なファイル

- `app/controllers/admin/movies_controller.rb`（編集）
- `app/views/admin/movies/edit.html.erb`（編集）
- `config/routes.rb`（編集）

### destroy アクションの例

```ruby
def destroy
  @movie = Movie.find(params[:id])
  @movie.destroy
  flash[:notice] = '映画が正常に削除されました。'
  redirect_to admin_movies_path
rescue ActiveRecord::RecordNotFound
  flash[:alert] = '指定された映画が見つかりません。'
  redirect_to admin_movies_path
rescue => e
  flash[:alert] = '映画の削除に失敗しました。'
  redirect_to admin_movies_path
end
```

### 削除ボタンの例

```erb
<div style="margin-top: 20px; padding-top: 20px; border-top: 1px solid #ccc;">
  <%= link_to "削除",
              admin_movie_path(@movie),
              method: :delete,
              data: { confirm: "この映画を削除しますか？削除すると元に戻せません。" },
              style: "background-color: #dc3545; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px;" %>
</div>
```

### ルーティングの確認

削除機能を追加後、以下のコマンドでルーティングを確認できます：

```bash
bundle exec rails routes | grep admin
```

以下のような出力が表示されれば成功です：

```
admin_movies     GET    /admin/movies               admin/movies#index
new_admin_movie  GET    /admin/movies/new           admin/movies#new
admin_movies     POST   /admin/movies               admin/movies#create
edit_admin_movie GET    /admin/movies/:id/edit      admin/movies#edit
admin_movie      PUT    /admin/movies/:id           admin/movies#update
admin_movie      DELETE /admin/movies/:id           admin/movies#destroy
```

### CSS スタイルの参考

削除ボタンを目立たせるためのスタイル例：

```css
.delete-button {
  background-color: #dc3545;
  color: white;
  padding: 10px 20px;
  text-decoration: none;
  border-radius: 4px;
  margin-left: 10px;
}

.delete-button:hover {
  background-color: #c82333;
  color: white;
  text-decoration: none;
}
```

### テスト項目（station05）

- GET /admin/movies/:id/edit で削除ボタンが表示される
- 削除ボタンクリック時に確認ダイアログが表示される
- 確認ダイアログで「キャンセル」を選んだ場合、削除されない
- 確認ダイアログで「OK」を選んだ場合、DELETE リクエストが送信される
- DELETE /admin/movies/:id で正常に削除できる
- 削除後、管理画面一覧に遷移する
- 削除成功時に適切な flash メッセージが表示される
- 存在しない ID での削除試行時に適切なエラーハンドリング

### 🎯 **初学者向け重要ポイント**

1. **物理削除とは**: データベースから完全にレコードを削除すること
2. **data-confirm**: Rails の便利機能で、簡単に確認ダイアログを作れる
3. **エラーハンドリング**: 問題が起きた時の対処法を事前に用意すること
4. **Flash メッセージ**: ユーザーに操作結果を伝える仕組み
5. **RESTful**: Rails の標準的な設計パターン（GET、POST、PUT、DELETE）

### 🚨 **注意事項**

- 削除は元に戻せない操作なので、必ず確認ダイアログを設置する
- エラーハンドリングを忘れずに実装する
- ユーザーにとって分かりやすいメッセージを心がける
- テストは様々なパターンで行う（正常系、異常系両方）

### 🔧 **発展課題（余裕があれば）**

- ページネーション機能の追加（kaminari gem など）
- 検索履歴の保存機能
- オートコンプリート機能
- ソート機能（公開年順、タイトル順など）
- お気に入り機能との連携

---

# lesson-6

## 課題概要

映画一覧画面に検索機能と上映状況による絞り込み機能を実装する。ユーザーがキーワード検索や上映状況（すべて/公開予定/公開中）で映画を絞り込めるようにし、より使いやすい映画一覧画面を提供する。

### 要件

- GET /movies にクエリパラメータを渡すことで映画を絞り込み表示できる
- 検索フォームとラジオボタン（すべて/公開予定/公開中）を設置する
- キーワード検索：映画のタイトルまたは概要にキーワードを含む映画のみ表示
- 上映状況絞り込み：is_showing の値に基づいて公開中/公開予定の映画のみ表示
- 検索フォームとラジオボタンの組み合わせ検索が可能
- デフォルトでは「すべて」が選択された状態で全映画を表示

### クエリパラメータの仕様

- `keyword=xxx`: タイトルまたは概要に"xxx"を含む映画のみ表示
- `is_showing=1`: 公開中の映画のみ表示（is_showing = true）
- `is_showing=0`: 公開予定の映画のみ表示（is_showing = false）
- パラメータなし: 全映画を表示

## 実装手順

### 1. MoviesController の index アクション拡張

- [ ] `app/controllers/movies_controller.rb` を編集
- [ ] index アクションに検索・絞り込み機能を追加
  - [ ] `params[:keyword]` でキーワード検索を処理
  - [ ] `params[:is_showing]` で上映状況絞り込みを処理
  - [ ] 複数条件の組み合わせ検索に対応
- [ ] Movie モデルにスコープメソッドを定義して検索処理を分離

#### 🔍 **初学者向け詳細説明**

クエリパラメータとは URL の `?` 以降に付く検索条件です。
例：`/movies?keyword=アクション&is_showing=1`

### 2. Movie モデルにスコープの追加

- [ ] `app/models/movie.rb` を編集
- [ ] キーワード検索用のスコープを追加
  - [ ] `scope :search_by_keyword, ->(keyword) { ... }`
  - [ ] タイトル（name）と概要（description）を LIKE 検索
- [ ] 上映状況絞り込み用のスコープを追加
  - [ ] `scope :filter_by_showing, ->(is_showing) { ... }`
  - [ ] is_showing カラムでの絞り込み

#### 🔍 **初学者向け詳細説明**

スコープとは、よく使う検索条件を再利用可能な形でモデルに定義する機能です。
コントローラーが複雑になるのを防ぎ、テストもしやすくなります。

### 3. index ビューファイルの拡張

- [ ] `app/views/movies/index.html.erb` を編集
- [ ] 検索フォームを追加
  - [ ] `form_with` を使用して GET メソッドのフォームを作成
  - [ ] キーワード入力フィールド（text_field）
  - [ ] 上映状況選択ラジオボタン（radio_button）
  - [ ] 検索ボタン（submit）
- [ ] フォームの初期値設定
  - [ ] キーワードフィールドに現在の検索キーワードを表示
  - [ ] ラジオボタンに現在の選択状態を反映

#### 🔍 **初学者向け詳細説明**

検索フォームは GET メソッドを使用します。これにより、検索結果の URL を共有したり、ブラウザの戻るボタンが正しく動作します。

### 4. 検索フォームの詳細実装

- [ ] キーワード検索フィールドの実装
  - [ ] `text_field_tag :keyword, params[:keyword]` でキーワード入力
  - [ ] プレースホルダーテキストを設定
- [ ] ラジオボタンの実装
  - [ ] 「すべて」: `radio_button_tag :is_showing, '', checked: params[:is_showing].blank?`
  - [ ] 「公開中」: `radio_button_tag :is_showing, '1', checked: params[:is_showing] == '1'`
  - [ ] 「公開予定」: `radio_button_tag :is_showing, '0', checked: params[:is_showing] == '0'`
- [ ] 各ラジオボタンにラベルを設定

#### 🔍 **初学者向け詳細説明**

- `text_field_tag`: フォームのテキスト入力フィールドを作成
- `radio_button_tag`: ラジオボタンを作成
- `checked:` オプション: 現在の選択状態を維持するために使用

### 5. コントローラーでの検索処理実装

- [ ] MoviesController の index アクションを以下のように実装

```ruby
def index
  @movies = Movie.all
  @movies = @movies.search_by_keyword(params[:keyword]) if params[:keyword].present?
  @movies = @movies.filter_by_showing(params[:is_showing]) if params[:is_showing].present?
end
```

```erb
<!-- View での座席表表示例 -->
<%= form_with url: movies_path, method: :get, local: true do |f| %>
  <div>
    <%= text_field_tag :keyword, params[:keyword], placeholder: "映画タイトルまたは概要で検索" %>
  </div>

  <div>
    <%= radio_button_tag :is_showing, '', checked: params[:is_showing].blank? %>
    <%= label_tag :is_showing_, "すべて" %>

    <%= radio_button_tag :is_showing, '1', checked: params[:is_showing] == '1' %>
    <%= label_tag :is_showing_1, "公開中" %>

    <%= radio_button_tag :is_showing, '0', checked: params[:is_showing] == '0' %>
    <%= label_tag :is_showing_0, "公開予定" %>
  </div>

  <div>
    <%= submit_tag "検索" %>
  </div>
<% end %>
```

#### 🔍 **初学者向け詳細説明**

- `present?`: 値が存在し、空でないかをチェック
- メソッドチェーン: 複数の条件を順次適用していく書き方

### 6. Movie モデルのスコープ実装

- [ ] キーワード検索スコープの実装

```ruby
scope :search_by_keyword, ->(keyword) {
  where("name LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%")
}
```

- [ ] 上映状況絞り込みスコープの実装

```ruby
scope :filter_by_showing, ->(is_showing) {
  where(is_showing: is_showing == '1')
}
```

#### 🔍 **初学者向け詳細説明**

- `LIKE ?`: SQL の部分一致検索（`%` は任意の文字列を表す）
- `where`: データベースから条件に合うレコードのみを取得

### 7. フォームのスタイリング

- [ ] 検索フォームを見やすくレイアウト
- [ ] CSS クラスを追加してスタイリング
- [ ] フォーム要素を適切に配置
  - [ ] キーワード入力フィールドとラジオボタンを横並びまたは縦並びに配置
  - [ ] 検索ボタンを分かりやすい位置に配置

#### 🔍 **初学者向け詳細説明**

ユーザビリティを向上させるため、フォームは見た目も重要です。
使いやすいレイアウトを心がけましょう。

### 8. 検索結果の表示改善

- [ ] 検索結果件数の表示
- [ ] 検索条件の表示（現在の絞り込み状態を表示）
- [ ] 検索結果が 0 件の場合のメッセージ表示
- [ ] 「検索条件をクリア」リンクの追加

#### 🔍 **初学者向け詳細説明**

ユーザーが現在どのような条件で検索しているかを明確に示すことで、
使いやすさが向上します。

### 9. エラーハンドリング

- [ ] 不正なパラメータが渡された場合の処理
- [ ] データベースエラーの処理
- [ ] 検索処理でのパフォーマンス考慮

#### 🔍 **初学者向け詳細説明**

検索機能では大量のデータを扱う可能性があるため、
適切なエラーハンドリングとパフォーマンス対策が重要です。

### 10. 動作確認

- [ ] サーバーを起動（`bundle exec rails server`）
- [ ] `http://localhost:3000/movies` にアクセス
- [ ] 検索フォームが表示されることを確認
- [ ] デフォルトで「すべて」が選択され、全映画が表示されることを確認
- [ ] キーワード検索の動作確認
  - [ ] 映画タイトルの一部で検索
  - [ ] 概要の一部で検索
  - [ ] 存在しないキーワードで検索（0 件表示の確認）
- [ ] 上映状況絞り込みの動作確認
  - [ ] 「公開中」を選択して検索
  - [ ] 「公開予定」を選択して検索
- [ ] 組み合わせ検索の動作確認
  - [ ] キーワード + 上映状況での絞り込み

### 11. URL とクエリパラメータの確認

- [ ] 検索後の URL にクエリパラメータが正しく含まれることを確認
- [ ] ブラウザの戻るボタンで検索状態が保持されることを確認
- [ ] URL を直接入力して検索条件が反映されることを確認
  - [ ] `/movies?keyword=アクション`
  - [ ] `/movies?is_showing=1`
  - [ ] `/movies?keyword=コメディ&is_showing=0`

### 12. テスト実行

- [ ] `bundle exec rspec spec/station06/` でテストを実行
- [ ] すべてのテストが通ることを確認

## 参考情報

### 必要なファイル

- `app/controllers/movies_controller.rb`（編集）
- `app/models/movie.rb`（編集）
- `app/views/movies/index.html.erb`（編集）

### MoviesController の例

```ruby
class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @movies = @movies.search_by_keyword(params[:keyword]) if params[:keyword].present?
    @movies = @movies.filter_by_showing(params[:is_showing]) if params[:is_showing].present?
  end
end
```

### Movie モデルのスコープ例

```ruby
class Movie < ApplicationRecord
  scope :search_by_keyword, ->(keyword) {
    where("name LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%")
  }

  scope :filter_by_showing, ->(is_showing) {
    where(is_showing: is_showing == '1')
  }
end
```

### 検索フォームの例

```erb
<%= form_with url: movies_path, method: :get, local: true do |f| %>
  <div>
    <%= text_field_tag :keyword, params[:keyword], placeholder: "映画タイトルまたは概要で検索" %>
  </div>

  <div>
    <%= radio_button_tag :is_showing, '', checked: params[:is_showing].blank? %>
    <%= label_tag :is_showing_, "すべて" %>

    <%= radio_button_tag :is_showing, '1', checked: params[:is_showing] == '1' %>
    <%= label_tag :is_showing_1, "公開中" %>

    <%= radio_button_tag :is_showing, '0', checked: params[:is_showing] == '0' %>
    <%= label_tag :is_showing_0, "公開予定" %>
  </div>

  <div>
    <%= submit_tag "検索" %>
  </div>
<% end %>
```

### 検索結果の表示例

```erb
<% if params[:keyword].present? || params[:is_showing].present? %>
  <div class="search-info">
    <h3>検索結果: <%= @movies.count %>件</h3>
    <% if params[:keyword].present? %>
      <p>キーワード: "<%= params[:keyword] %>"</p>
    <% end %>
    <% if params[:is_showing].present? %>
      <p>上映状況: <%= params[:is_showing] == '1' ? '公開中' : '公開予定' %></p>
    <% end %>
    <%= link_to "検索条件をクリア", movies_path %>
  </div>
<% end %>
```

### CSS スタイルの例

```css
.search-form {
  background-color: #f8f9fa;
  padding: 20px;
  border-radius: 5px;
  margin-bottom: 20px;
}

.search-form input[type="text"] {
  padding: 8px;
  margin-right: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.search-form input[type="radio"] {
  margin-right: 5px;
  margin-left: 15px;
}

.search-form input[type="submit"] {
  background-color: #007bff;
  color: white;
  padding: 8px 16px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
```

### テスト項目（station06）

- GET /movies でデフォルト状態（全映画表示）が正しく動作する
- キーワード検索が正しく動作する（タイトル・概要の部分一致）
- 上映状況絞り込みが正しく動作する（公開中・公開予定）
- キーワードと上映状況の組み合わせ検索が正しく動作する
- 検索フォームの初期値が正しく設定される
- 検索結果が 0 件の場合も適切に表示される
- クエリパラメータが URL に正しく反映される
- 不正なパラメータでもエラーにならない

### 🎯 **初学者向け重要ポイント**

1. **スコープ**: モデルに検索ロジックを分離することで、コントローラーがシンプルになる
2. **クエリパラメータ**: GET リクエストで検索条件を URL に含める仕組み
3. **LIKE 検索**: データベースでの部分一致検索の方法
4. **フォームの状態保持**: 検索後もフォームの入力値を保持する重要性
5. **ユーザビリティ**: 検索結果の件数表示や条件クリア機能の価値

### 🚨 **注意事項**

- 検索機能はパフォーマンスに影響するため、大量データでの動作も考慮する
- SQL インジェクション対策として、必ず Rails のクエリメソッドを使用する
- ユーザーの入力値は適切にサニタイズする
- 検索結果が 0 件の場合のユーザー体験も考慮する

### 🔧 **発展課題（余裕があれば）**

- ページネーション機能の追加（kaminari gem など）
- 検索履歴の保存機能
- オートコンプリート機能
- ソート機能（公開年順、タイトル順など）
- お気に入り機能との連携

---

# lesson-7

## 課題概要

映画館の座席表を表示する機能を実装する。座席予約機能の第一歩として、スクリーンに対しての座席の位置と座席の番号を表形式で表示できるようにする。

### 要件

- GET /sheets で座席表を表示する
- sheets テーブルに座席表マスターデータを格納する
- マスターデータを元にループ処理で座席表を表示する
- table タグを使用して表形式で座席表を表示する
- 座席配置は 3 行 5 列（a-1 から c-5）でスクリーンが上部に表示される

### 座席配置

```
|.    |.    |スクリーン|.    |.    |
|-----|-----|-------|-----|-----|
| a-1 | a-2 | a-3   | a-4 | a-5 |
| b-1 | b-2 | b-3   | b-4 | b-5 |
| c-1 | c-2 | c-3   | c-4 | c-5 |
```

### テーブル仕様

```sql
CREATE TABLE IF NOT EXISTS `railway`.`sheets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `column` TINYINT(5) NOT NULL,
  `row` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`id`)
)
```

### マスターデータ

```sql
INSERT INTO `sheets` VALUES
(1, 1, 'a'), (2, 2, 'a'), (3, 3, 'a'), (4, 4, 'a'), (5, 5, 'a'),
(6, 1, 'b'), (7, 2, 'b'), (8, 3, 'b'), (9, 4, 'b'), (10, 5, 'b'),
(11, 1, 'c'), (12, 2, 'c'), (13, 3, 'c'), (14, 4, 'c'), (15, 5, 'c');
```

## 実装手順

### 1. Sheet モデルの作成

- [ ] `app/models/sheet.rb` ファイルを作成
- [ ] ApplicationRecord を継承した Sheet クラスを定義
- [ ] 必要な属性：id, column, row

#### 🔍 **初学者向け詳細説明**

Sheet モデルは座席情報を管理するためのモデルです。
各座席は行（row）と列（column）で位置を特定します。

### 2. マイグレーションファイルの作成

- [ ] `bundle exec rails generate migration CreateSheets` でマイグレーション生成
- [ ] または手動で `db/migrate/YYYYMMDD_create_sheets.rb` を作成
- [ ] テーブル定義を実装
  - [ ] `t.integer :column, null: false` (列番号)
  - [ ] `t.string :row, limit: 1, null: false` (行記号)
  - [ ] インデックスの追加を検討

#### 🔍 **初学者向け詳細説明**

マイグレーションはデータベースのテーブル構造を管理するための機能です。
座席テーブルには列番号（1-5）と行記号（a-c）を格納します。

### 3. シードデータの作成

- [ ] `db/seeds.rb` ファイルを編集
- [ ] 座席マスターデータの投入処理を追加
- [ ] 重複データの考慮（既存データがある場合のハンドリング）

```ruby
# 座席マスターデータの投入例
seats_data = [
  { column: 1, row: 'a' }, { column: 2, row: 'a' }, { column: 3, row: 'a' }, { column: 4, row: 'a' }, { column: 5, row: 'a' },
  { column: 1, row: 'b' }, { column: 2, row: 'b' }, { column: 3, row: 'b' }, { column: 4, row: 'b' }, { column: 5, row: 'b' },
  { column: 1, row: 'c' }, { column: 2, row: 'c' }, { column: 3, row: 'c' }, { column: 4, row: 'c' }, { column: 5, row: 'c' }
]

seats_data.each do |seat|
  Sheet.find_or_create_by(seat)
end
```

#### 🔍 **初学者向け詳細説明**

シードデータは開発やテスト用の初期データです。
`find_or_create_by` を使用することで重複登録を防げます。

### 4. SheetsController の作成

- [ ] `app/controllers/sheets_controller.rb` ファイルを作成
- [ ] ApplicationController を継承した SheetsController クラスを定義
- [ ] index アクションを実装
  - [ ] `Sheet.all` で全座席データを取得
  - [ ] 行（row）でグループ化して座席配置を整理
  - [ ] `@seats_by_row` インスタンス変数に代入

#### 🔍 **初学者向け詳細説明**

座席表を表示するため、データベースから座席情報を取得し、
行ごとにグループ化して表示しやすい形に整理します。

### 5. ルーティングの設定

- [ ] `config/routes.rb` を編集
- [ ] `resources :sheets, only: [:index]` または `get '/sheets', to: 'sheets#index'` を追加

#### 🔍 **初学者向け詳細説明**

`GET /sheets` のルーティングを設定することで、
ブラウザから `/sheets` にアクセスした時に座席表が表示されます。

### 6. View ファイルの作成

- [ ] `app/views/sheets` ディレクトリを作成
- [ ] `app/views/sheets/index.html.erb` ファイルを作成
- [ ] HTML ファイルの基本構造を作成（DOCTYPE html を含む）
- [ ] スクリーン表示部分を実装
- [ ] 座席表の table 構造を実装
  - [ ] thead でヘッダー部分（スクリーン表示）
  - [ ] tbody で座席配置
  - [ ] 行ごとにループして各座席を表示
  - [ ] 座席番号の表示（例：a-1, b-2）

#### 🔍 **初学者向け詳細説明**

座席表は以下の構造で表示します：

- 上部にスクリーン表示
- 3 行 5 列の座席配置
- 各座席は「行記号-列番号」で表示（例：a-1）

### 7. 座席表示ロジックの実装

- [ ] SheetsController で座席データを行ごとに整理
- [ ] ビューで座席配置を table で表現
- [ ] スクリーン位置の表示
- [ ] 座席番号のフォーマット設定

```ruby
# Controller での座席データ整理例
def index
  @seats_by_row = Sheet.all.group_by(&:row).sort
end
```

```erb
<!-- View での座席表表示例 -->
<table class="seat-map">
  <thead>
    <tr>
      <th colspan="5" class="screen">スクリーン</th>
    </tr>
  </thead>
  <tbody>
    <% @seats_by_row.each do |row, seats| %>
      <tr>
        <% seats.sort_by(&:column).each do |seat| %>
          <td class="seat"><%= seat.seat_number %></td>
        <% end %>
      </tr>
    <% end %>
  </tbody>
</table>
```

#### 🔍 **初学者向け詳細説明**

- `group_by(&:row)`: 行ごとに座席をグループ化
- `sort_by(&:column)`: 列番号順でソート
- `colspan="5"`: スクリーン表示を 5 列分に拡張

### 8. CSS スタイリングの追加

- [ ] 座席表のスタイリングを実装
- [ ] スクリーン部分の装飾
- [ ] 座席の見た目を整える
- [ ] レスポンシブ対応を検討

```css
/* 座席表のスタイル例 */
.seat-map {
  margin: 20px auto;
  border-collapse: collapse;
}

.seat-map th,
.seat-map td {
  border: 1px solid #ddd;
  padding: 15px;
  text-align: center;
}

.screen {
  background-color: #333;
  color: white;
  font-weight: bold;
}

.seat {
  background-color: #f8f9fa;
}

.seat:hover {
  background-color: #e9ecef;
}
```

#### 🔍 **初学者向け詳細説明**

座席表は映画館らしい見た目にするため、適切なスタイリングを施します。
将来的に座席選択機能を追加することも考慮した設計にします。

### 9. データベースマイグレーション実行

- [ ] `bundle exec rails db:migrate` でマイグレーション実行
- [ ] `bundle exec rails db:seed` でシードデータ投入
- [ ] データが正しく投入されたか確認

#### 🔍 **初学者向け詳細説明**

データベースの準備：

1. マイグレーション実行でテーブル作成
2. シードデータ投入で座席マスターデータ登録
3. Rails console で確認: `Sheet.count` → 15 件表示されることを確認

### 10. 動作確認

- [ ] サーバーを起動（`bundle exec rails server`）
- [ ] `http://localhost:3000/sheets` にアクセス
- [ ] HTTP ステータス 200 が返されることを確認
- [ ] HTML が返されることを確認（DOCTYPE html が含まれる）
- [ ] table タグで座席表が表示されることを確認
- [ ] スクリーン表示が上部にあることを確認
- [ ] 3 行 5 列の座席配置が正しく表示されることを確認
- [ ] 各座席が「行記号-列番号」形式で表示されることを確認

#### 🔍 **初学者向け詳細説明**

動作確認は「作った機能が正しく動くか」をチェックする重要な作業です。
実際にボタンを押してみて、期待通りの動作をするか確認しましょう。

### 11. エラーハンドリング

- [ ] データベース接続エラーの処理
- [ ] シードデータが投入されていない場合の処理
- [ ] 座席データが不正な場合の処理

#### 🔍 **初学者向け詳細説明**

座席表機能では以下のエラーを考慮します：

- データベースにアクセスできない場合
- 座席データが存在しない場合
- データが破損している場合

### 12. テスト実行

- [ ] `bundle exec rspec spec/station07/` でテストを実行
- [ ] すべてのテストが通ることを確認

## 参考情報

### 必要なファイル

- `app/models/sheet.rb`（新規作成）
- `app/controllers/sheets_controller.rb`（新規作成）
- `app/views/sheets/index.html.erb`（新規作成）
- `db/migrate/YYYYMMDD_create_sheets.rb`（新規作成）
- `db/seeds.rb`（編集）
- `config/routes.rb`（編集）

### Sheet モデルの例

```ruby
class Sheet < ApplicationRecord
  validates :column, presence: true, inclusion: { in: 1..5 }
  validates :row, presence: true, inclusion: { in: %w[a b c] }

  def seat_number
    "#{row}-#{column}"
  end
end
```

### SheetsController の例

```ruby
class SheetsController < ApplicationController
  def index
    @seats_by_row = Sheet.all.group_by(&:row).sort
  rescue => e
    flash[:alert] = '座席情報の取得に失敗しました。'
    @seats_by_row = {}
  end
end
```

### マイグレーションファイルの例

```ruby
class CreateSheets < ActiveRecord::Migration[7.0]
  def change
    create_table :sheets do |t|
      t.integer :column, null: false
      t.string :row, limit: 1, null: false

      t.timestamps
    end

    add_index :sheets, [:row, :column], unique: true
  end
end
```

### ビューファイルの例

```erb
<% content_for :title, "座席表" %>

<style>
  .seat-map {
    margin: 20px auto;
    border-collapse: collapse;
  }
  .seat-map th, .seat-map td {
    border: 1px solid #ddd;
    padding: 15px;
    text-align: center;
  }
  .screen {
    background-color: #333;
    color: white;
    font-weight: bold;
  }
  .seat {
    background-color: #f8f9fa;
  }
</style>

<h1>座席表</h1>

<table class="seat-map">
  <thead>
    <tr>
      <th colspan="5" class="screen">スクリーン</th>
    </tr>
  </thead>
  <tbody>
    <% @seats_by_row.each do |row, seats| %>
      <tr>
        <% seats.sort_by(&:column).each do |seat| %>
          <td class="seat"><%= seat.seat_number %></td>
        <% end %>
      </tr>
    <% end %>
  </tbody>
</table>
```

### シードデータの例

```ruby
# db/seeds.rb
puts "座席マスターデータを投入中..."

seats_data = [
  { column: 1, row: 'a' }, { column: 2, row: 'a' }, { column: 3, row: 'a' }, { column: 4, row: 'a' }, { column: 5, row: 'a' },
  { column: 1, row: 'b' }, { column: 2, row: 'b' }, { column: 3, row: 'b' }, { column: 4, row: 'b' }, { column: 5, row: 'b' },
  { column: 1, row: 'c' }, { column: 2, row: 'c' }, { column: 3, row: 'c' }, { column: 4, row: 'c' }, { column: 5, row: 'c' }
]

seats_data.each do |seat|
  Sheet.find_or_create_by(seat)
end
```

### テスト項目（station07）

- GET /sheets が 200 ステータスで返される
- HTML が返される（DOCTYPE html が含まれる）
- table タグが使用されている
- スクリーン表示が上部にある
- 3 行 5 列の座席配置が正しく表示される
- 各座席が「行記号-列番号」形式で表示される
- 全 15 席が表示される
- 座席データがデータベースから正しく取得される

### 🎯 **初学者向け重要ポイント**

1. **マスターデータ**: 変更されない基本的なデータの管理方法
2. **シードデータ**: 開発・テスト用の初期データ投入機能
3. **group_by**: データを特定の条件でグループ化する便利な機能
4. **テーブル表示**: HTML の table タグを使った構造化されたデータ表示
5. **座席配置**: 実際の映画館を模した直感的なレイアウト設計

### 🚨 **注意事項**

- マイグレーション実行前にデータベースのバックアップを取る
- シードデータは重複実行を考慮した実装にする
- 座席表示は将来の予約機能拡張を考慮した設計にする
- レスポンシブデザインを考慮して様々な画面サイズで確認する

### 🔧 **発展課題（余裕があれば）**

- 座席の空席/予約済み状態表示
- 座席種別（通常席/プレミアム席など）の追加
- スクリーンサイズや座席レイアウトの動的変更機能
- 座席表のズーム機能
- アクセシビリティ対応（スクリーンリーダー対応など）

---

# lesson-8

## 課題概要

映画作品の詳細ページと上映スケジュール表示機能を実装する。各映画の詳細情報を表示し、上映中の映画にはその映画に紐づく上映スケジュールも表示する。

### 要件

- GET /movies/:id で指定した ID の映画作品詳細ページを表示する
- 映画の全カラム情報を表示する
- 画像は img タグで表示する
- その映画作品に紐づく上映スケジュールをすべて表示する
- Schedules モデルを作成し、Movies との 1 対 N の関係を設定する
- 上映開始時刻と終了時刻を表示する

### テーブル仕様

schedules テーブル:

- id: 主キー
- movie_id: movies テーブルへの外部キー
- start_time: 上映開始時刻（TIME 型）
- end_time: 上映終了時刻（TIME 型）
- created_at, updated_at: タイムスタンプ

## 実装手順

### 1. Schedule モデルの作成

- [ ] `app/models/schedule.rb` ファイルを作成
- [ ] ApplicationRecord を継承した Schedule クラスを定義
- [ ] 必要な属性：id, movie_id, start_time, end_time
- [ ] Movie モデルとのアソシエーション設定（belongs_to :movie）

#### 🔍 **初学者向け詳細説明**

Schedule モデルは映画の上映スケジュール情報を管理するためのモデルです。
各スケジュールは特定の映画に紐づき、開始時刻と終了時刻を持ちます。

### 2. マイグレーションファイルの作成

- [ ] `docker compose exec web bundle exec rails generate migration CreateSchedules` でマイグレーション生成
- [ ] または手動で `db/migrate/YYYYMMDD_create_schedules.rb` を作成
- [ ] テーブル定義を実装
  - [ ] `t.references :movie, null: false, foreign_key: true` (映画への外部キー)
  - [ ] `t.time :start_time, null: false` (上映開始時刻)
  - [ ] `t.time :end_time, null: false` (上映終了時刻)
  - [ ] インデックスの追加（movie_id）

#### 🔍 **初学者向け詳細説明**

外部キーを使用することで、どの映画にどのスケジュールが紐づくかを管理できます。
TIME 型を使用することで時刻のみを効率的に格納できます。

### 3. Movie モデルの拡張

- [ ] `app/models/movie.rb` を編集
- [ ] Schedule モデルとのアソシエーション設定（has_many :schedules）
- [ ] 上映中の映画かどうかを判定するメソッドを追加（必要に応じて）

#### 🔍 **初学者向け詳細説明**

1 対 N の関係では、「1」側のモデル（Movie）に `has_many`、
「N」側のモデル（Schedule）に `belongs_to` を設定します。

### 4. ルーティングの設定

- [ ] `config/routes.rb` を編集
- [ ] movies に show アクションを追加
- [ ] `resources :movies, only: [:index, :show]` に変更

#### 🔍 **初学者向け詳細説明**

show アクションを追加することで、個別の映画詳細ページにアクセスできるようになります。
URL: `/movies/1`, `/movies/2` など

### 5. MoviesController の拡張

- [ ] `app/controllers/movies_controller.rb` を編集
- [ ] show アクションを追加
  - [ ] `Movie.find(params[:id])` で指定 ID の映画を取得
  - [ ] @movie インスタンス変数に代入
  - [ ] 関連する上映スケジュールも取得（@movie.schedules）
  - [ ] レコードが見つからない場合の例外処理

#### 🔍 **初学者向け詳細説明**

show アクションでは、URL の :id パラメータを使用して特定の映画データを取得します。
同時に、その映画に紐づく上映スケジュールも取得します。

### 6. 映画一覧ページの編集

- [ ] `app/views/movies/index.html.erb` を編集
- [ ] 各映画のタイトルを詳細ページへのリンクに変更
- [ ] `link_to movie.name, movie_path(movie)` として実装

#### 🔍 **初学者向け詳細説明**

映画一覧ページから詳細ページに遷移できるようにリンクを設置します。
ユーザーが映画タイトルをクリックすると詳細ページに移動します。

### 7. 映画詳細ページの作成

- [ ] `app/views/movies/show.html.erb` ファイルを作成
- [ ] HTML ファイルの基本構造を作成（DOCTYPE html を含む）
- [ ] 映画の詳細情報表示部分を実装
  - [ ] 映画タイトル（name）
  - [ ] 公開年（year）
  - [ ] 概要（description）
  - [ ] 画像（image_url を img タグで表示）
  - [ ] 上映状況（is_showing）
- [ ] 上映スケジュール表示部分を実装
  - [ ] 上映中の映画の場合のみスケジュール表示
  - [ ] table タグで上映時間を表示
  - [ ] 開始時刻と終了時刻を表示

#### 🔍 **初学者向け詳細説明**

詳細ページでは映画のすべての情報を表示します。
上映中の映画（is_showing が true）の場合のみ、上映スケジュールを表示します。

### 8. 上映スケジュール表示の実装

- [ ] 上映中かどうかの判定ロジック実装
- [ ] 上映スケジュール一覧の表示
- [ ] 時刻の表示フォーマット設定
- [ ] スケジュールがない場合のメッセージ表示

```erb
<!-- 上映スケジュール表示例 -->
<% if @movie.is_showing? %>
  <h3>上映スケジュール</h3>
  <% if @movie.schedules.any? %>
    <table class="schedule-table">
      <thead>
        <tr>
          <th>上映開始時刻</th>
          <th>上映終了時刻</th>
        </tr>
      </thead>
      <tbody>
        <% @movie.schedules.each do |schedule| %>
          <tr>
            <td><%= schedule.start_time.strftime("%H:%M") %></td>
            <td><%= schedule.end_time.strftime("%H:%M") %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
  <% else %>
    <p>上映スケジュールはまだ決まっていません。</p>
  <% end %>
<% end %>
```

#### 🔍 **初学者向け詳細説明**

- `is_showing?`: 上映中かどうかを判定
- `schedules.any?`: スケジュールが存在するかを確認
- `strftime("%H:%M")`: 時刻を「HH:MM」形式で表示

### 9. バリデーションの追加

- [ ] Schedule モデルにバリデーションを追加
  - [ ] movie_id の presence バリデーション
  - [ ] start_time の presence バリデーション
  - [ ] end_time の presence バリデーション
  - [ ] 終了時刻が開始時刻より後であることのバリデーション

#### 🔍 **初学者向け詳細説明**

データの整合性を保つため、適切なバリデーションを設定します。
特に、終了時刻が開始時刻より後であることは重要な制約です。

### 10. テストデータの作成

- [ ] `db/seeds.rb` ファイルを編集
- [ ] 上映スケジュールのテストデータを追加
- [ ] 複数の映画に対して複数のスケジュールを作成

```ruby
# 上映スケジュールのテストデータ例
if Movie.exists?
  Movie.where(is_showing: true).each do |movie|
    # 1日3回上映のスケジュール例
    [
      { start_time: '10:00', end_time: '12:00' },
      { start_time: '14:00', end_time: '16:00' },
      { start_time: '18:00', end_time: '20:00' }
    ].each do |schedule_data|
      movie.schedules.find_or_create_by(schedule_data)
    end
  end
end
```

#### 🔍 **初学者向け詳細説明**

テストデータでは上映中の映画に対してのみスケジュールを作成します。
実際の映画館のように 1 日複数回上映されることを想定しています。

### 11. エラーハンドリング

- [ ] MoviesController の show アクションにエラーハンドリングを追加
- [ ] レコードが見つからない場合の処理（ActiveRecord::RecordNotFound）
- [ ] データベースエラーの処理
- [ ] 404 ページへのリダイレクトまたは適切なエラーメッセージ

#### 🔍 **初学者向け詳細説明**

存在しない映画 ID でアクセスされた場合のエラーハンドリングが重要です。
ユーザーフレンドリーなエラーメッセージを表示しましょう。

### 12. データベースマイグレーション実行

- [ ] `docker compose exec web bundle exec rails db:migrate` でマイグレーション実行
- [ ] `docker compose exec web bundle exec rails db:seed` でシードデータ投入
- [ ] `docker compose exec web bundle exec rails console` でコンソールを開き、データが正しく投入されたか確認

#### 🔍 **初学者向け詳細説明**

マイグレーション実行で schedules テーブルが作成され、
シードデータ投入で上映スケジュールのテストデータが登録されます。

### 13. 動作確認

- [ ] サーバーを起動（`docker compose up`）
- [ ] `http://localhost:3000/movies` にアクセス
- [ ] 映画タイトルがリンクになっていることを確認
- [ ] 映画タイトルをクリックして詳細ページに移動することを確認
- [ ] `http://localhost:3000/movies/1` で詳細ページが表示されることを確認
- [ ] 映画の全カラム情報が表示されることを確認
- [ ] 画像が img タグで表示されることを確認
- [ ] 上映中の映画の場合、上映スケジュールが表示されることを確認
- [ ] 上映予定の映画の場合、スケジュールが表示されないことを確認

#### 🔍 **初学者向け詳細説明**

動作確認では、実際のユーザーの操作を想定してテストします。
一覧ページから詳細ページへの遷移、詳細情報の表示など、
すべての機能が正しく動作することを確認しましょう。

### 14. スタイリングの追加

- [ ] 詳細ページのスタイリングを実装
- [ ] 映画情報の見やすいレイアウト
- [ ] 上映スケジュール表のスタイリング
- [ ] レスポンシブ対応

#### 🔍 **初学者向け詳細説明**

詳細ページは情報量が多いため、見やすいレイアウトが重要です。
映画のポスター画像を大きく表示し、情報を整理して配置しましょう。

### 15. テスト実行

- [ ] `docker compose exec web bundle exec rspec spec/station08/` でテストを実行
- [ ] すべてのテストが通ることを確認

## 参考情報

### 必要なファイル

- `app/models/schedule.rb`（新規作成）
- `app/models/movie.rb`（編集）
- `app/controllers/movies_controller.rb`（編集）
- `app/views/movies/show.html.erb`（新規作成）
- `app/views/movies/index.html.erb`（編集）
- `db/migrate/YYYYMMDD_create_schedules.rb`（新規作成）
- `db/seeds.rb`（編集）
- `config/routes.rb`（編集）

### Schedule モデルの例

```ruby
class Schedule < ApplicationRecord
  belongs_to :movie

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time

  private

  def end_time_after_start_time
    return unless start_time && end_time

    if end_time <= start_time
      errors.add(:end_time, 'は開始時刻より後に設定してください')
    end
  end
end
```

### Movie モデルの拡張例

```ruby
class Movie < ApplicationRecord
  has_many :schedules, dependent: :destroy

  # 既存のバリデーション...

  def showing?
    is_showing
  end
end
```

### MoviesController の拡張例

```ruby
class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @movies = @movies.search_by_keyword(params[:keyword]) if params[:keyword].present?
    @movies = @movies.filter_by_showing(params[:is_showing]) if params[:is_showing].present?
  end

  def show
    @movie = Movie.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = '指定された映画が見つかりません。'
    redirect_to movies_path
  end
end
```

### マイグレーションファイルの例

```ruby
class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.references :movie, null: false, foreign_key: true
      t.time :start_time, null: false
      t.time :end_time, null: false

      t.timestamps
    end

    add_index :schedules, :movie_id
  end
end
```

### 詳細ページビューの例

```erb
<% content_for :title, "#{@movie.name} - 映画詳細" %>

<style>
  .movie-detail {
    max-width: 800px;
    margin: 20px auto;
    padding: 20px;
  }
  .movie-poster {
    max-width: 300px;
    height: auto;
  }
  .schedule-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
  }
  .schedule-table th,
  .schedule-table td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: center;
  }
  .schedule-table th {
    background-color: #f8f9fa;
  }
</style>

<div class="movie-detail">
  <h1><%= @movie.name %></h1>

  <div class="movie-info">
    <% if @movie.image_url.present? %>
      <img src="<%= @movie.image_url %>" alt="<%= @movie.name %>" class="movie-poster">
    <% end %>

    <p><strong>公開年:</strong> <%= @movie.year %></p>
    <p><strong>概要:</strong> <%= @movie.description %></p>
    <p><strong>上映状況:</strong> <%= @movie.is_showing? ? '上映中' : '上映予定' %></p>
  </div>

  <% if @movie.is_showing? %>
    <h3>上映スケジュール</h3>
    <% if @movie.schedules.any? %>
      <table class="schedule-table">
        <thead>
          <tr>
            <th>上映開始時刻</th>
            <th>上映終了時刻</th>
          </tr>
        </thead>
        <tbody>
          <% @movie.schedules.each do |schedule| %>
            <tr>
              <td><%= schedule.start_time.strftime("%H:%M") %></td>
              <td><%= schedule.end_time.strftime("%H:%M") %></td>
            </tr>
          <% end %>
        </tbody>
      </table>
    <% else %>
      <p>上映スケジュールはまだ決まっていません。</p>
    <% end %>
  <% end %>

  <p><%= link_to '映画一覧に戻る', movies_path %></p>
</div>
```

### シードデータの追加例

```ruby
# db/seeds.rb
puts "上映スケジュールのテストデータを投入中..."

# 上映中の映画にスケジュールを追加
Movie.where(is_showing: true).each do |movie|
  schedules_data = [
    { start_time: '10:00', end_time: '12:00' },
    { start_time: '14:00', end_time: '16:00' },
    { start_time: '18:00', end_time: '20:00' }
  ]

  schedules_data.each do |schedule_data|
    movie.schedules.find_or_create_by(schedule_data)
  end
end

puts "上映スケジュールのテストデータ投入完了"
```

### テスト項目（station08）

- GET /movies/:id が 200 ステータスで返される
- HTML が返される（DOCTYPE html が含まれる）
- 映画の全カラム情報が表示される
- 画像が img タグで表示される
- 上映中の映画の場合、上映スケジュールが表示される
- 上映予定の映画の場合、スケジュールが表示されない
- 映画一覧ページから詳細ページへのリンクが機能する
- 存在しない映画 ID でアクセスした場合の適切なエラーハンドリング
- Movies と Schedules のアソシエーションが正しく設定されている

### 🎯 **初学者向け重要ポイント**

1. **1 対 N の関係**: 1 つの映画に対して複数のスケジュールが存在する関係
2. **外部キー**: 他のテーブルのレコードを参照するためのキー
3. **アソシエーション**: モデル間の関係を表現する Rails の機能
4. **TIME 型**: 時刻のみを格納するデータ型
5. **条件分岐表示**: 上映状況に応じた表示の切り替え

### 🚨 **注意事項**

- 外部キー制約を適切に設定する
- 終了時刻が開始時刻より後であることを検証する
- 存在しない映画 ID でのアクセスに対するエラーハンドリング
- 上映スケジュールがない場合の適切なメッセージ表示

### 🔧 **発展課題（余裕があれば）**

- 上映スケジュールの時刻表示を 12 時間制/24 時間制切り替え
- 映画の上映時間（duration）カラムを追加
- 上映スケジュールの並び順を時刻順にソート
- 過去の上映スケジュールを表示しない機能
- 映画詳細ページでの座席予約機能への導線

---

# lesson-9

## 課題概要

管理画面から上映スケジュールの一覧、追加、編集、削除を行える機能を実装する。映画作品と同様の CRUD 機能を提供するが、スケジュールは映画作品に紐づくため、映画作品の管理画面から遷移する形で実装する。

### 要件

- GET /admin/schedules でスケジュール一覧を表示する
  - 作品 ID・作品名を見出し（h2 タグ）にし、その下にその作品の開始時刻・終了時刻をリストアップ
  - スケジュールが設定されていない作品は表示しない
  - schedules の全件・全カラムを表示する
  - 各スケジュールはリンクになっていて、リンク先は GET /admin/schedules/:id
- GET /admin/movies/:id にリンクを追加
  - その作品に対応する GET /admin/schedules/:id へのリンクを置く
  - GET /admin/movies/:id/schedules/new へのリンクを追加する
- GET /admin/schedules/:id でスケジュール編集フォームを表示
  - 開始時刻と終了時刻のフォーム
  - movie_id は変更不可（必要なら削除して新規追加）
  - 削除ボタンあり（確認ダイアログ付き）
- PUT /admin/schedules/:id で更新処理
- DELETE /admin/schedules/:id で削除処理（物理削除）

### 画面上の表記とカラム名の対応

- movie_id: 作品 ID
- start_time: 開始時刻
- end_time: 終了時刻
- created_at: 作成日時
- updated_at: 更新日時

## 実装手順

### 1. ルーティングの設定

- [ ] `config/routes.rb` を編集
- [ ] admin 名前空間に schedules リソースを追加
- [ ] movies リソースの member 内に schedules#new を追加

```ruby
namespace :admin do
  resources :movies, only: [:index, :new, :create, :edit, :update, :destroy] do
    member do
      get 'schedules/new', to: 'schedules#new'
    end
  end
  resources :schedules, only: [:index, :edit, :update, :destroy]
end
```

#### 🔍 **初学者向け詳細説明**

`member do`ブロックを使用することで、特定の映画に対するスケジュール新規作成画面へのルーティングを設定できます。
これにより`/admin/movies/:id/schedules/new`という URL が使用可能になります。

### 2. Admin::SchedulesController の作成

- [ ] `app/controllers/admin/schedules_controller.rb` ファイルを作成
- [ ] ApplicationController を継承した Admin::SchedulesController クラスを定義
- [ ] 各アクションを実装

```ruby
class Admin::SchedulesController < ApplicationController
  before_action :set_schedule, only: [:edit, :update, :destroy]

  def index
    @movies_with_schedules = Movie.joins(:schedules).distinct.includes(:schedules)
  end

  def new
    @movie = Movie.find(params[:id])
    @schedule = @movie.schedules.build
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = '指定された映画が見つかりません。'
    redirect_to admin_movies_path
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @schedule = @movie.schedules.build(schedule_params)

    if @schedule.save
      flash[:notice] = 'スケジュールが正常に作成されました。'
      redirect_to edit_admin_movie_path(@movie)
    else
      flash[:alert] = 'スケジュールの作成に失敗しました。'
      render :new, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = '指定された映画が見つかりません。'
    redirect_to admin_movies_path
  end

  def edit
    @movie = @schedule.movie
  end

  def update
    if @schedule.update(schedule_params)
      flash[:notice] = 'スケジュールが正常に更新されました。'
      redirect_to admin_schedules_path
    else
      flash[:alert] = 'スケジュールの更新に失敗しました。'
      render :edit, status: :bad_request
    end
  end

  def destroy
    movie = @schedule.movie
    @schedule.destroy
    flash[:notice] = 'スケジュールが正常に削除されました。'
    redirect_to edit_admin_movie_path(movie)
  rescue => e
    flash[:alert] = 'スケジュールの削除に失敗しました。'
    redirect_to admin_schedules_path
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = '指定されたスケジュールが見つかりません。'
    redirect_to admin_schedules_path
  end

  def schedule_params
    params.require(:schedule).permit(:start_time, :end_time)
  end
end
```

#### 🔍 **初学者向け詳細説明**

- `before_action`: 特定のアクションの前に実行されるメソッドを指定
- `joins(:schedules)`: スケジュールを持つ映画のみを取得
- `distinct`: 重複を除去
- `includes(:schedules)`: N+1 問題を防ぐため関連データを事前読み込み

### 3. スケジュール一覧ビューの作成

- [ ] `app/views/admin/schedules` ディレクトリを作成
- [ ] `app/views/admin/schedules/index.html.erb` ファイルを作成
- [ ] 映画ごとにスケジュールを表示

```erb
<% content_for :title, "スケジュール管理" %>

<style>
  .schedule-section {
    margin-bottom: 30px;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 5px;
  }
  .schedule-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
  }
  .schedule-table th,
  .schedule-table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
  }
  .schedule-table th {
    background-color: #f8f9fa;
  }
</style>

<h1>スケジュール一覧</h1>

<% @movies_with_schedules.each do |movie| %>
  <div class="schedule-section">
    <h2>作品ID: <%= movie.id %> - <%= movie.name %></h2>

    <table class="schedule-table">
      <thead>
        <tr>
          <th>ID</th>
          <th>開始時刻</th>
          <th>終了時刻</th>
          <th>作成日時</th>
          <th>更新日時</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
        <% movie.schedules.order(:start_time).each do |schedule| %>
          <tr>
            <td><%= link_to schedule.id, edit_admin_schedule_path(schedule) %></td>
            <td><%= schedule.start_time.strftime("%H:%M") %></td>
            <td><%= schedule.end_time.strftime("%H:%M") %></td>
            <td><%= schedule.created_at.strftime("%Y-%m-%d %H:%M") %></td>
            <td><%= schedule.updated_at.strftime("%Y-%m-%d %H:%M") %></td>
            <td><%= link_to "編集", edit_admin_schedule_path(schedule) %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
  </div>
<% end %>

<p><%= link_to "映画管理に戻る", admin_movies_path %></p>
```

#### 🔍 **初学者向け詳細説明**

- 映画ごとにセクションを分けて表示
- h2 タグで作品 ID・作品名を表示
- 各スケジュールの ID をリンクにして編集画面へ遷移可能に

### 4. 映画編集画面へのリンク追加

- [ ] `app/views/admin/movies/edit.html.erb` を編集
- [ ] スケジュール関連のリンクを追加

```erb
<div style="margin-top: 20px; padding-top: 20px; border-top: 1px solid #ccc;">
  <h3>スケジュール管理</h3>

  <% if @movie.schedules.any? %>
    <h4>現在のスケジュール</h4>
    <ul>
      <% @movie.schedules.order(:start_time).each do |schedule| %>
        <li>
          <%= schedule.start_time.strftime("%H:%M") %> - <%= schedule.end_time.strftime("%H:%M") %>
          <%= link_to "編集", edit_admin_schedule_path(schedule) %>
        </li>
      <% end %>
    </ul>
  <% else %>
    <p>スケジュールが設定されていません。</p>
  <% end %>

  <p><%= link_to "新規スケジュール追加", admin_movie_schedules_new_path(@movie), style: "background-color: #28a745; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px;" %></p>
</div>
```

#### 🔍 **初学者向け詳細説明**

映画編集画面に、その映画に紐づくスケジュールの一覧と新規追加リンクを表示します。
これにより、映画管理とスケジュール管理がスムーズに連携します。

### 5. スケジュール新規作成ビューの作成

- [ ] `app/views/admin/schedules/new.html.erb` ファイルを作成
- [ ] 新規作成フォームを実装

```erb
<% content_for :title, "スケジュール新規作成" %>

<h1>スケジュール新規作成</h1>
<h2>映画: <%= @movie.name %></h2>

<% if @schedule.errors.any? %>
  <div style="color: red;">
    <ul>
      <% @schedule.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
    </ul>
  </div>
<% end %>

<%= form_with model: [:admin, @schedule], url: admin_schedules_path, local: true do |f| %>
  <%= hidden_field_tag :movie_id, @movie.id %>

  <div class="field">
    <%= f.label :start_time, "開始時刻" %>
    <%= f.time_field :start_time, required: true %>
  </div>

  <div class="field">
    <%= f.label :end_time, "終了時刻" %>
    <%= f.time_field :end_time, required: true %>
  </div>

  <div class="actions">
    <%= f.submit "作成" %>
  </div>
<% end %>

<p><%= link_to "映画編集画面に戻る", edit_admin_movie_path(@movie) %></p>
```

#### 🔍 **初学者向け詳細説明**

- `hidden_field_tag`: 画面に表示されないフィールドで映画 ID を送信
- `time_field`: HTML5 の時刻入力フィールド
- フォームの送信先は`admin_schedules_path`（POST）

### 6. スケジュール編集ビューの作成

- [ ] `app/views/admin/schedules/edit.html.erb` ファイルを作成
- [ ] 編集フォームと削除ボタンを実装

```erb
<% content_for :title, "スケジュール編集" %>

<h1>スケジュール編集</h1>
<h2>映画: <%= @movie.name %></h2>

<% if @schedule.errors.any? %>
  <div style="color: red;">
    <ul>
      <% @schedule.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
    </ul>
  </div>
<% end %>

<%= form_with model: [:admin, @schedule], local: true do |f| %>
  <div class="field">
    <%= f.label :start_time, "開始時刻" %>
    <%= f.time_field :start_time, required: true %>
  </div>

  <div class="field">
    <%= f.label :end_time, "終了時刻" %>
    <%= f.time_field :end_time, required: true %>
  </div>

  <p><small>※作品IDは変更できません。別の映画のスケジュールにしたい場合は、このスケジュールを削除して新規作成してください。</small></p>

  <div class="actions">
    <%= f.submit "更新" %>
  </div>
<% end %>

<div style="margin-top: 20px; padding-top: 20px; border-top: 1px solid #ccc;">
  <%= link_to "削除",
              admin_schedule_path(@schedule),
              method: :delete,
              data: { confirm: "このスケジュールを削除しますか？削除すると元に戻せません。" },
              style: "background-color: #dc3545; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px;" %>
</div>

<p><%= link_to "スケジュール一覧に戻る", admin_schedules_path %></p>
```

#### 🔍 **初学者向け詳細説明**

- movie_id は変更不可のため、フォームには含めない
- 削除ボタンには確認ダイアログを設定
- 削除後は映画編集画面に戻るよう設計

### 7. ルーティングの追加修正

- [ ] `config/routes.rb` を再編集
- [ ] schedules#create アクションを追加

```ruby
namespace :admin do
  resources :movies, only: [:index, :new, :create, :edit, :update, :destroy] do
    member do
      get 'schedules/new', to: 'schedules#new'
    end
  end
  resources :schedules, only: [:index, :create, :edit, :update, :destroy]
end
```

#### 🔍 **初学者向け詳細説明**

create アクションを追加することで、新規作成フォームからの POST リクエストを処理できるようになります。

### 8. エラーハンドリングの強化

- [ ] Schedule モデルのバリデーションを確認
- [ ] コントローラーの例外処理を追加
- [ ] 適切なエラーメッセージを設定

#### 🔍 **初学者向け詳細説明**

データの整合性を保つため、Schedule モデルには以下のバリデーションが設定されているはずです：

- 開始時刻と終了時刻の必須チェック
- 終了時刻が開始時刻より後であることのチェック

### 9. 動作確認

- [ ] サーバーを起動（`bundle exec rails server`）
- [ ] `http://localhost:3000/admin/movies` にアクセス
- [ ] 映画編集画面でスケジュール関連のリンクが表示されることを確認
- [ ] 新規スケジュール作成が正常に動作することを確認
- [ ] `http://localhost:3000/admin/schedules` でスケジュール一覧が表示されることを確認
- [ ] スケジュールの編集・更新が正常に動作することを確認
- [ ] スケジュールの削除が正常に動作することを確認（確認ダイアログも確認）

#### 🔍 **初学者向け詳細説明**

動作確認では以下の点を重点的にチェックします：

- 映画とスケジュールの関連が正しく保たれているか
- エラー時のメッセージが適切に表示されるか
- 削除時の確認ダイアログが機能しているか

### 10. スタイリングの追加

- [ ] 各ビューに CSS を追加
- [ ] フォームのレイアウト調整
- [ ] エラーメッセージの見た目を改善
- [ ] レスポンシブ対応

#### 🔍 **初学者向け詳細説明**

管理画面として統一感のあるデザインを心がけ、操作しやすい UI を実装します。

### 11. テスト実行

- [ ] `bundle exec rspec spec/station09/` でテストを実行
- [ ] すべてのテストが通ることを確認

## 参考情報

### 必要なファイル

- `app/controllers/admin/schedules_controller.rb`（新規作成）
- `app/views/admin/schedules/index.html.erb`（新規作成）
- `app/views/admin/schedules/new.html.erb`（新規作成）
- `app/views/admin/schedules/edit.html.erb`（新規作成）
- `app/views/admin/movies/edit.html.erb`（編集）
- `config/routes.rb`（編集）

### テスト項目（station09）

- GET /admin/schedules が 200 ステータスで返される
- スケジュール一覧が映画ごとにグループ化されて表示される
- 各スケジュールの ID がリンクとして機能する
- GET /admin/movies/:id にスケジュール関連のリンクが表示される
- GET /admin/movies/:id/schedules/new で新規作成フォームが表示される
- POST /admin/schedules で正常に作成できる
- GET /admin/schedules/:id で編集フォームが表示される
- PUT /admin/schedules/:id で正常に更新できる
- DELETE /admin/schedules/:id で正常に削除できる
- エラー時に適切な flash メッセージが表示される

### 🎯 **初学者向け重要ポイント**

1. **ネストしたルーティング**: 映画に紐づくスケジュールの新規作成 URL を実現
2. **joins と includes**: 効率的なデータ取得と N+1 問題の回避
3. **before_action**: 共通処理を DRY に実装
4. **hidden_field**: フォームで見えない値を送信する方法
5. **data-confirm**: 削除時の確認ダイアログ実装

### 🚨 **注意事項**

- movie_id は編集画面で変更不可にする
- スケジュールが存在しない映画は一覧に表示しない
- 削除は物理削除で実装
- エラーハンドリングを適切に実装する

### 🔧 **発展課題（余裕があれば）**

- スケジュールの一括登録機能
- 曜日別のスケジュール設定
- スケジュールのコピー機能
- 上映期間の設定機能
- スケジュールの重複チェック機能
