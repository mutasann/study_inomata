class ExtraController < ApplicationController
  def sendmail
    user = User.find(params[:id])
    @mail = NoticeMailer.sendmail_confirm(user).deliver_now
    render plain:'メールが正しく送信されました'
  end
end
