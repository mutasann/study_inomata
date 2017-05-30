class ReservationMailMailer < ApplicationMailer
  
  def sendmail_confirm(user)
    @user = user

    mail to: user.email
    subject: 'レッスン予約が完了しました。'
  end
end
