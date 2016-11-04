class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def user_params
    params.require(:user).permit(:username, :password, :email, secrets_attributes: [:id, :title, :description])
  end

  def create
    User.new(user_params)
  end

  def index
    if user_signed_in?
      redirect_to user_path(@user.id)
    else
      redirect_to new_user_session_path
    end
  end

  def edit
    if user_signed_in?
      redirect_to user_path(@user.id)
    else
      redirect_to new_user_session_path
    end
  end

  def update
    if user_signed_in?
      redirect_to user_path(@user.id)
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @user = User.find(params[:id])
    @allowed = @user.id = current_user.id
    @secrets = @user.secrets
  end
end
