class SecretsController < ApplicationController
  before_action :authenticate_user!
 
  def secret_params
    params.require(:secret).permit(:title, :description);
  end 

  def index
    redirect_to user_path(current_user)
  end

  def new
    @user = User.find(params[:user_id])
    @allowed = @user.id == current_user.id
    @new_or_edit = :new
    if !user_signed_in?
      flash[:warning] = "You need to sign-in first"
      redirect_to new_user_session_path
    elsif !@allowed
      flash[:warning] = "You can't add to #{@user.username}'s secrets"
      redirect_to user_path(current_user)
    else
      @secret = Secret.new
    end
  end

  def create
    @user = User.find(params[:user_id])
    @secret = @user.secrets.new(secret_params)
    if @secret.save
      flash[:success] = "New secret added successfully"
      redirect_to user_secret_path(@user, @secret)
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @allowed = @user.id =  current_user.id
    @new_or_edit = :edit
    if !user_signed_in?
      flash[:warning] = "You need to sign-in first"
      redirect_to new_user_session_path
    elsif !@allowed
      flash[:warning] = "You can't edit  #{@user.username}'s secrets"
      redirect_to user_path(current_user)
    else
      @secret = Secret.find(params[:id])
    end
  end

  def update
    @secret = Secret.find(params[:id])
    if @secret.update(secret_params)
      flash[:success] = "Secret edited successfully."
      redirect_to user_secret_path(current_user, @secret)
    else
      flash[:error] = "Secret was not edited successfully. Please try again."
      redirect_to edit_user_secret_path(current_user, @secret)
    end
  end

  def show
    @user = User.find(params[:user_id])
    @allowed = @user.id == current_user.id
    if !user_signed_in?
      flash[:warning] = "You need to sign-in first"
      redirect_to new_user_session_path
    elsif !@allowed
      flash[:warning] = "You can't edit  #{@user.username}'s secrets"
      redirect_to user_path(current_user)
    else
      @secret = Secret.find(params[:id])
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @allowed = @user.id == current_user.id
    if !user_signed_in?
      flash[:warning] = "You need to sign-in first"
      redirect_to new_user_session_path
    elsif !@allowed
      flash[:warning] = "You can't delete  #{@user.username}'s secrets"
      redirect_to user_path(current_user)
    else
      @secret = Secret.find(params[:id])
      if @secret.destroy
        flash[:success] = "The secret was successfully destroyed"
        redirect_to user_path(current_user)
      else
        flash[:success] = "Could not destory the secret"
        redirect_to user_secret_path(current_user, @secret)
      end
    end
  end

end
