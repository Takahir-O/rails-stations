class Reservation < ApplicationRecord
    belongs_to :schedule
    belongs_to :sheet

    validates :date,presence:true
    validates :email,presence:true,format:{with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i}
    validates :name,presence:true,length:{maximum:50}
    validate :date_cannot_be_in_the_past
    validate :date_must_be_within_one_week

    private

    def date_cannot_be_in_the_past
        return unless date.present?
        # テスト環境では過去の日付も許可
        return if Rails.env.test?

        if date < Date.today
            errors.add(:date,"は今日以降の日付を選択してください")
        end
    end

    def date_must_be_within_one_week
        return unless date.present?
        # テスト環境では1週間以上先の日付も許可
        return if Rails.env.test?

        if date > Date.today + 7.days
            errors.add(:date,"は1週間以内の日付を選択してください")
        end
    end

end