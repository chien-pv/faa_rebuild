class TemporaryRegistrationsSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :address, :comment, :created_at,
    :course_name, :list_periods
  belongs_to :course

   def course_name
    object.course.name
  end

  def list_periods
    Period.find(object.periods).map{|p| ["#{p.start_time.strftime('%I:%M%p')} - #{p.end_time.strftime('%I:%M%p')}"]}
  end
end
