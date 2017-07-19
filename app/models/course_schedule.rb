class CourseSchedule < ApplicationRecord
  has_many :registrations, dependent: :destroy
  belongs_to :course

  DAY_OF_WEEK = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]

  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :newest, ->{order start_date: :desc}
  scope :load_by_course, -> course_id{newest.where course_id: course_id}

  delegate :name, to: :course, prefix: true, allow_nil: true
  delegate :cost, to: :course, prefix: true, allow_nil: true
  delegate :technique, to: :course, prefix: true, allow_nil: true

  def is_opening?
    self.start_date >= Date.today
  end
end
