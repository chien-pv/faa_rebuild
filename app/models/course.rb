class Course < ApplicationRecord
  acts_as_paranoid
  has_many :images, as: :imageable, dependent: :destroy
  has_many :course_schedules, dependent: :destroy
  has_many :registrations, through: :course_schedules
  has_many :temporary_registrations, dependent: :destroy
  has_many :course_periods, dependent: :destroy
  has_many :periods, through: :course_periods
  has_one :avatar, class_name: Image.name, foreign_key: :id, primary_key: :avatar_id
  has_one :cover, class_name: Image.name, foreign_key: :id, primary_key: :cover_id
  has_one :newest_schedule,
    -> {where("start_date >= ?", Date.today).order(start_date: :desc)},
    class_name: CourseSchedule.name, foreign_key: :course_id

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  def slug_candidates
    [:name]
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  accepts_nested_attributes_for :images, allow_destroy: true

  scope :popular, -> do
    left_joins(:registrations).group(:id)
      .order("COUNT(registrations.id) DESC").first Settings.courses.popular
  end
  scope :newest, -> do
    includes(:newest_schedule, :images)
      .order("course_schedules.start_date desc nulls last")
  end
  scope :by_words, -> words{where("LOWER(name) LIKE ?", "%#{words.downcase}%")}

  enum status: {opening: 0, closed: 1}

  validates :name, presence: true, length: {
    maximum: Settings.courses.max_name_length,
    minimum: Settings.courses.min_name_length}
  validates :description, presence: true, length: {
    maximum: Settings.courses.max_description_length,
    minimum: Settings.courses.min_description_length}
  validates :cost, allow_nil: true, numericality: {greater_than_or_equal_to: 0}
  validates :content, presence: true

  def images_attributes= attributes
    self.images.delete_all
    super
  end
end
