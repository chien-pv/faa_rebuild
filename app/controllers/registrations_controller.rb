class RegistrationsController < ApplicationController
  before_action :load_course, only: [:new, :create]
  before_action :find_course_schedule, only: :new

  def new
    if @course
      if params[:schedule] && @course_schedule
        @registration = @course_schedule.registrations.build
      else
        @registration = Registration.new
        load_and_group_by_branch_course_schedules
      end
    end
  end

  def create
    @registration = Registration.new registration_params
    ActiveRecord::Base.transaction do
      load_and_group_by_branch_course_schedules
      if @registration.valid? && @course
        if is_exists_params_course_schedule_id?
          save_registration
        elsif params[:course_schedule_ids].present?
          import_registrations
        end
      elsif params[:course_schedule_ids].blank? || @registration.invalid?
        flash.now[:danger] = t ".fail"
      end
    end
  rescue
    flash.now[:danger] = t ".fail"
  end

  private

  def registration_params
    params.require(:registration).permit(:name, :email,
      :address, :phone, :course_schedule_id).merge! reason: params[:reason]
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

  def import_registrations
    registrations = []
    params[:course_schedule_ids].each do |course_schedule_id|
      registrations << Registration.new(registration_params.merge! course_schedule_id: course_schedule_id)
    end
    Registration.import! registrations
    flash.now[:success] = t ".success"
  end

  def is_exists_params_course_schedule_id?
    params[:registration].present? && params[:registration][:course_schedule_id].present?
  end

  def save_registration
    @registration.course_schedule_id = params[:registration][:course_schedule_id]
    @registration.save!
    flash.now[:success] = t ".success"
  end

  def load_and_group_by_branch_course_schedules
    if @course
      @hash_course_schedules = @course.course_schedules.load_by_course_schedule.
        group_by &:branch_id
    end
  end
end
