# Controller to signup new users
class RegistrationsController < ApplicationController
  skip_before_action :authorize

  before_action :check_logged_in, except: :logout
  before_action :initialize_user, only: :create_user
  before_action :set_user_by_email, only: %i[login_user]

  def signup
    @user = User.new
  end

  def create_user
    if @user.save
      redirect_to login_url, notice: 'User signed up, Login now.'
    else
      render :signup, status: :unprocessable_entity
    end
  end

  def login_user
    if @user.try(:authenticate, params[:password])
      set_cookies
      redirect_to root_path, notice: 'Logged In'
    else
      flash.now[:alert] = t('.invalid')
      render :login
    end
  end

  def logout
    cookies.delete(:identifier)
    redirect_to login_path, notice: t('.logged_out')
  end

  private def initialize_user
    @user = User.new(user_params)
  end

  private def set_user_by_email
    @user = User.find_by(email: params[:email])
    redirect_to login_path, alert: t('errors.users.not_found') unless @user
  end

  private def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  private def set_cookies
    cookies[:identifier] = params[:remember_me] == '1' ? { value: @user.identifier, expires: 10.days.from_now } : @user.identifier
  end
end
