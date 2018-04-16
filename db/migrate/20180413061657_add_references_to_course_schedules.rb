class AddReferencesToCourseSchedules < ActiveRecord::Migration[5.0]
  def change
    add_reference :course_schedules, :branch, index: true, foreign_key: true
  end
end
