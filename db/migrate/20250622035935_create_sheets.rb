class CreateSheets < ActiveRecord::Migration[7.1]
  def change
    create_table :sheets do |t|
      t.integer :column, null: false
      t.string :row, limit: 1, null: false

      t.timestamps
    end

    # screen_idが追加された後に適切なユニーク制約が追加されるため、ここでは削除
    # add_index :sheets, [:row, :column], unique: true
  end
end
