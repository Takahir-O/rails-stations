class Screen < ApplicationRecord
    has_many :schedules, dependent: :destroy
    has_many :sheets, dependent: :destroy

    validates :name,presence: true,uniqueness: true

end