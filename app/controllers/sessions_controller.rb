class SessionsController < ApplicationController
  skip_before_action :check_logined

  def new
  end

  def create
    user = User.find_by(login_id: params[:session][:login_id].downcase)
    if user && user.authenticate(params[:session][:password]) then
      log_in user
      redirect_to '/top'
    else
      flash.now[:referer] = params[:referer]
      @error = 'ユーザー名/パスワードが間違っています。'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_url
  end
end
