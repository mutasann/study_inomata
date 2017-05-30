class ApplicationController < ActionController::Base
include SessionsHelper
  before_action :current_user, :check_logined


  private

  def check_logined
    if @current_user == nil
      redirect_to login_path
    elsif @current_user.user_type == "teacher"
    else
      redirect_to mypage_path
    end
  end

  def user_is_student?
    @current_user.user_type == "student"
  end

  def authorize_for_user
    user = User.find(params[:id])
    if user_is_student? && @current_user.id != user.id
      redirect_to mypage_path
    end
  end

end
