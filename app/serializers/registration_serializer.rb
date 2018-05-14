class RegistrationSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :address, :course_name, :comment,
    :course_schedule_code, :created_at, :reason_name
  has_one :course
  has_one :course_schedule

  def course_name
    object.course.name
  end

  def course_schedule_code
    object.course_schedule.code
  end

  def reason_name
    full_name = ""
    object.reason.each do |reason_id|
      full_name += Registration.list_reasons.keys[reason_id&.to_i]
      full_name += ", " if object.reason.last != reason_id
    end
    full_name
  end
end
