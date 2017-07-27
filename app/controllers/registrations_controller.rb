class RegistrationsController < ApplicationController
  before_action :find_course_schedule, only: :new

  def new
    @registration = @course_schedule.registrations.build
    respond_to do |format|
      format.js
    end
  end

  def create
    @registration = Registration.new registration_params
    if @registration.save
      flash.now[:success] = t ".success"
    else
      flash.now[:danger] = t ".fail"
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def registration_params
    params.require(:registration).permit :course_schedule_id, :name, :email,
      :address, :phone
  end

  def find_course_schedule
    @course_schedule = CourseSchedule.find params[:schedule]
  rescue ActiveRecord::RecordNotFound
    handle_record_not_found
  end
end
