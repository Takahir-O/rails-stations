class Schedule < ApplicationRecord
    belongs_to :movie
    has_many :reservations,dependent: :destroy
    belongs_to :screen

    validates :start_time,presence: true
    validates :end_time,presence:true
    validate :end_time_after_start_time

    private
    def end_time_after_start_time
        return unless start_time && end_time
        
        if end_time <= start_time
            errors.add(:end_time,"は開始時間より後に設定してください")
        end
    end

end