# Preview all emails at http://localhost:3000/rails/mailers/reservation_mail_mailer
class NoticeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reservation_mail_mailer/sendmail_confirm
  def sendmail_confirm
    user = User.find(2)
    NoticeMailer.sendmail_confirm(user)
  end

end
