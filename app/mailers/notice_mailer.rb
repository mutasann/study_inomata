class NoticeMailer < ApplicationMailer
  default from: 'webmaster@wings.msn.to',
          cc: 'CQW15204@nifty.com'

  def sendmail_confirm(reservation)
    @reservation = reservation
    @reservation = Reservation.find(@reservation.id)
    mail to: @reservation.user.email,
         subject: 'Lessonご予約ありがとうございます'
  end

  # def reservation_post(reservation)
  #   @reservation = reservation
  #
  #   mail to: @reservation.user.email,
  #        subject: 'Lessonご予約ありがとうございます'
  # end
end
