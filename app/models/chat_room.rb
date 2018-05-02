class ChatRoom < ApplicationRecord
  has_many :messages, dependent: :destroy

  after_commit :send_room_infomation

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

  scope :newest, ->{order created_at: :desc}

  def send_room_infomation
    ListRoomJob.perform_now self
  end
end
