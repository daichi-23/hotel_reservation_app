class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :room

    validates :start_date, presence: true
    validates :end_date, presence: true
    validate :start_date_check
    validate :date_check
    validates :person_num, presence: true, numericality: {greater_than_or_equal_to: 1}
    
    def start_date_check
      if start_date.present?
        errors.add(:start_date, "は本日以降の日付で選択してください。") unless
        Date.today <= self.start_date
      end
    end
    def date_check
      if start_date.present? && end_date.present?
        errors.add(:end_date, "日はチェックイン日より後の日付で選択してください。") unless
        self.start_date < self.end_date
      end
    end
    def days_count
      (end_date - start_date).to_i
    end
    def price_count
      room = Room.find(room_id)
      (end_date - start_date).to_i * person_num * room.price
    end

end
