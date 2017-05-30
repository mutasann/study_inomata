class StudentsController < ApplicationController
  skip_before_action :check_logined
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]


  def index
    # @reservations = Reservation.where(user_id: @current_user.id)
    @reservations = @current_user.reservations
  end

  def new
    @reservation = Reservation.new
  end

  private
    def set_reservation
      @reservation = Reservation.find_by(reservaion: params[:user_id])
    end

end
