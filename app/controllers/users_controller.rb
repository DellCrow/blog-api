class UsersController < ApplicationController
  include BCrypt
  before_action :authorized, only: [:auto_login]
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # REGISTER
  def create
    @user = User.create(user_params)

    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}, status: :created
    else
      render json: {error: 'Invalid username or email'}, status: :not_acceptable
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(email: params[:email])

    # puts

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: 'Invalid username or password'}, status: :unauthorized
    end
  end

  def auto_login
    render json: @user
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      @user.update!(user_params)
      format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
      format.json { render :show, status: :ok, location: @user }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
