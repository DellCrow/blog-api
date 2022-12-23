class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
  rescue_from ActiveRecord::RecordNotUnique, with: :render_not_unique
  rescue_from ActionController::UnknownFormat, with: :render_not_found

  private
  def render_not_found e
    render json: e.message, status: :not_found
  end

  def render_invalid e
    render json: e.record.errors, status: :unprocessable_entity
  end

  def render_not_unique e
    render json:  {error: e.message }, status: :unprocessable_entity
  end
end
