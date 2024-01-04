class Attendance < ApplicationRecord
  belongs_to :employee
  default_scope -> { order(:start_work_date) }
  validates :employee_id, presence: true
  validates :break_time, presence: true, numericality: {greater_than_or_equal_to: 0}
end
