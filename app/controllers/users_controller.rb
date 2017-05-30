class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  skip_before_action :check_logined, only: [ :show, :update, :new, :create ]

  def index
    @users = User.all
  end

  def show
    authorize_for_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new( user_params )
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end


  def edit
    authorize_for_user
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.'}
      else
        format.html { render :edit }
      end
    end
  end


  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :login_id, :password, :user_type, :email)
  end
end
