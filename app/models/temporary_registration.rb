class TemporaryRegistration < ApplicationRecord
  acts_as_paranoid
  belongs_to :course
  serialize :periods, Array
  serialize :schedules, Array

  VALID_EMAIL_REGEX = /\A([A-Za-z0-9_.]+)@((?:[-a-z0-9]+\.)+[a-z]{2,4})\Z/
  VALID_PHONE_NUMBER_REGEX = /\A\+?\d{1,3}?[- .]?\(?(?:\d{2,3})\)?[- .]?\d\d\d[- .]?\d\d\d\d/
  validates :name, presence: true,
    length: {maximum: Settings.registrations.max_name_length}
  validates :email, presence: true,
    length: {maximum: Settings.registrations.max_email_length},
    format: {with: VALID_EMAIL_REGEX}
  validates :phone, presence: true,
    length: {maximum: Settings.registrations.max_phone_length},
    format: {with: VALID_PHONE_NUMBER_REGEX}
  validates :address, length:
    {maximum: Settings.registrations.max_address_length}, allow_blank: true
  validates :course_id, presence: true
  validates :address, presence: true

  scope :search_by_course_name_phone, -> word{
    joins(:course).where("LOWER(courses.name) LIKE ? OR LOWER(temporary_registrations.name) LIKE ?" \
      "OR temporary_registrations.phone LIKE ?",
      "%#{word}%", "%#{word}%", "%#{word}%")
  }

  delegate :name, to: :course, prefix: true, allow_nil: true
end
