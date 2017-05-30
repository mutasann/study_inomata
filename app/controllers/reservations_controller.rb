  class ReservationsController < ApplicationController
  skip_before_action :check_logined, only: [:show, :new, :edit, :create, :update, :destroy, :set_reservation, :reservation_params]
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :id_filter, only: [:show, :edit, :update, :destroy]

  def index
    @reservations = Reservation.all
  end

  def show
  end

  def new
    @reservation = Reservation.new
  end

  def edit
  end

  def create
    @reservation=Reservation.new(reservation_params)
    respond_to do |format|
      if @reservation.save
        NoticeMailer.sendmail_confirm(@reservation).deliver_now
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully update.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  def set_reservation
      @reservation = Reservation.find(params[:id])
  end

  def reservation_params
      params.require(:reservation).permit(:user_id, :lesson_id, :date_time)
  end

  def user_filter
    reservation = Reservation.find(params[:id])
    #変更理由<インスタンス変数を使用すると何度もサーバーを呼び出すことになるのでページ内で済む処理に変更しローカル変数を使用>
    #reservationで予約したstudentsは必ず本人なので、そこから取得したreservation:idから本人のuser_idを紐づけ、取り出す事ができる
    @current_user.id == reservation.user_id
    #ローカル変数のuser_idとcurrent_userのidを照合
  end

  def id_filter
    if user_filter
    else
      redirect_to mypage_path
    end
  end
end
