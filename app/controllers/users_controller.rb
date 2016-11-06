class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def user_params
    params.require(:user).permit(:username, :password, :email, secrets_attributes: [:id, :title, :description])
  end

  def create
    User.new(user_params)
  end

  def index
    if user_signed_in?
      redirect_to user_path(current_user.id)
    else
      redirect_to new_user_session_path
    end
  end

  def edit
    if user_signed_in?
      redirect_to user_path(current_user.id)
    else
      redirect_to new_user_session_path
    end
  end

  def update
    if user_signed_in?
      redirect_to user_path(current_user.id)
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @user = User.find(params[:id])
    @allowed = @user.id == current_user.id
	  if !user_signed_in?
      flash[:warning] = "You need to sign-in first"
      redirect_to new_user_session_path
    elsif !@allowed
      flash[:warning] = "You cannot access another user's secrets"
      redirect_to user_path(current_user)
    else
    	if User.exists?(id: params[:id])
    	  @user = User.find(params[:id])
    	  @secrets = @user.secrets
    	 else
    	  render_404
    	 end
		end
  end
end
