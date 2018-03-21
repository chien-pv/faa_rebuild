class CreateCoursePeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :course_periods do |t|
      t.references :course, foreign_key: true
      t.references :period, foreign_key: true

      t.timestamps

    end
  end
end
