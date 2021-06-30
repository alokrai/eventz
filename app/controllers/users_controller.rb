class UsersController < ApplicationController

  before_action :require_signin, except: %i[new create]
  before_action :require_correct_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'thanks for signing up'
    else
      render :new
    end
  end

  def edit; end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.delete
    session[:user_id] = nil
    redirect_to '/', alert: 'account successfully deleted'
  end

  private

  def user_params
    params[:user].permit(:name, :email, :password, :password_confirmation)
  end

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to events_url unless current_user? @user
  end
end
