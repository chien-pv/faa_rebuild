class SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_to_on_destroy
    cookies.delete :admin_id
    respond_to do |format|
      format.json {render json: {status: 200, message: t(".logout_success")}}
      format.html
    end
  end

  def after_sign_in_path_for resource
    cookies.signed[:admin_id] = current_admin.id
    admin_path
  end
end
