class UsersController < ApplicationController
  before_action :authorized, only: %i[ show destroy update ]

  # POST /user
  def create
    @user = User.new(user_params)

    if @user.save!
      @token = encode_token({user_id: @user.id})
      render :show, status: :created
    else
      render json: {error: 'Invalid username or password'}, status: :not_acceptable
    end
  end

  # POST /login
  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      @token = encode_token({user_id: @user.id})
      render :show, status: :ok
    else
      render json: {error: 'Invalid username or password'}, status: :unauthorized
    end
  end

  # GET /user
  def show
  end

  # PUT /user
  def update
    @user.update!(user_params)
    render action: :show, status: :ok
  end

  # DELETE /user
  def destroy
    @user.destroy
    head :no_content
  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
  end