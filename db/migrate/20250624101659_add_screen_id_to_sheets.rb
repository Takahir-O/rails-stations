class AddScreenIdToSheets < ActiveRecord::Migration[7.1]
  def change
    add_reference :sheets,:screen,null:true,foreign_key:true

    # 既存データが存在する際にはスクリーン1に割り当てる。
    reversible do |dir|
      dir.up do
        # デフォルトのスクリーンを作成する
        screen1 = Screen.find_or_create_by(name: "スクリーン1")

        # 既存の座席を全てスクリーン1に割り当てる
        Sheet.update_all(screen_id: screen1.id)

        # null制約を追加する
        change_column_null :sheets, :screen_id, false
      end
    end

    add_index :sheets, [:screen_id, :row, :column], unique: true
  end
end
