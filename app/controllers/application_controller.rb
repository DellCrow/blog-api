class ApplicationController < ActionController::Base
  before_action :authorized
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
  rescue_from ActiveRecord::RecordNotUnique, with: :render_not_unique
  rescue_from ActionController::UnknownFormat, with: :render_not_found

  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: {error: 'Please log in'}, status: :unauthorized unless logged_in?
  end

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
