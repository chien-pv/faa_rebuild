class V1::TemporaryRegistrationsController < V1::ApiController
  before_action :load_registration_course, only: [:destroy, :update]

  def index
    search_word = params[:query] || ""
    course_id = params[:course_id].to_i

    q_ransack = TemporaryRegistration.ransack set_params_q search_word, course_id
    registration_courses = q_ransack.result.includes(:course).order(created_at: :desc)
      .page(page).per Settings.admin_page.per_page

    registration_serialize = ActiveModel::SerializableResource
      .new(registration_courses, each_serializer: TemporaryRegistrationsSerializer)
    response_success nil, {registration_courses: registration_serialize, courses: Course.all(),
      page: page, pages: registration_courses.total_pages, }
  end

  def update
    if @registration_course.update(comment: params[:comment])
      response_success t(".delete_success"), @registration_course
    else
      response_error t(".delete_failed"), @registration_course.errors.full_messages
    end
  end

  def destroy
    if @registration_course.destroy
      response_success t(".delete_success"), @registration_course
    else
      response_error t(".delete_failed"), nil
    end
  end

  private

  def load_registration_course
    return if @registration_course = TemporaryRegistration.find_by(id: params[:id])
    response_not_found t(".not_found"), nil
  end

  def set_params_q search_word, course_id
    params[:q] = {
      name_or_phone_or_email_cont: search_word,
      course_id_eq: course_id.zero? ? nil : course_id,
    }
  end
end

