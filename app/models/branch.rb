class Branch < ApplicationRecord
  has_many :course_schedules, dependent: :destroy
end
