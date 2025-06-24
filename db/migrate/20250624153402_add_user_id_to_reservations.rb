class AddUserIdToReservations < ActiveRecord::Migration[7.1]
  def up
    # 一時的にnull許可してカラムを追加
    add_reference :reservations, :user, null: false, foreign_key: true

    # 既存データの移行
    migrate_existing_reservations

    # null制約を追加
    change_column_null :reservations, :user_id, false
  end

  def down
    remove_reference :reservations, :user, foreign_key: true
  end

  private

  def migrate_existing_reservations
    # 既存の予約データに対してユーザーを作成し、紐づける
    Reservation.where(user_id: nil).find_each do |reservation|
      # 同じname+emailの組み合わせでユーザーを検索または作成
      user = User.find_or_create_by(
        name: reservation.name,
        email: reservation.email
      ) do |u|
        # パスワードランダムに生成
        u.password = SecureRandom.alphanumeric(12)
        u.password_confirmation = u.password
    end

    reservation.update!(user_id: user.id)
    end
  end
end
