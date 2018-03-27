class RegistrationsController < ApplicationController
  before_action :load_course, only: [:new, :create]
  before_action :find_course_schedule, only: :new

  def new
    if params[:schedule]
      @registration = @course_schedule.registrations.build
    else
      @registration = Registration.new
    end
    respond_to do |format|
      format.js
    end
  end

  def create
    ActiveRecord::Base.transaction do
      params[:course_schedule_ids].each do |course_schedule_id|
        @registration = Registration.new registration_params.merge!(course_schedule_id: course_schedule_id)
        if @registration.save
          flash.now[:success] = t ".success"
        else
          flash.now[:danger] = t ".fail"
        end
      end
      respond_to do |format|
        format.js
      end
    end
  rescue
    flash.now[:danger] = t ".fail"
  end

  private

  def registration_params
    params.require(:registration).permit :name, :email,
      :address, :phone
  end

  def find_course_schedule
    if params[:schedule]
      @course_schedule = CourseSchedule.find params[:schedule]
    end
  rescue ActiveRecord::RecordNotFound
    handle_record_not_found
  end

  def load_course
    @course = Course.friendly.find params[:course]
  rescue ActiveRecord::RecordNotFound
    handle_record_not_found
  end
end
