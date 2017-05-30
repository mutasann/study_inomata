require 'test_helper'

class NoticeMailerTest < ActionMailer::TestCase
  test "sendmail_confirm" do
    # メールを送信後キューに追加されるかどうかをテスト
    email = NoticeMailer.create_invite('webmaster@wings.msn.to',
                                     'masamasa.nukkonuko@gmail.com', Time.now).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    # 送信されたメールの本文が期待どおりの内容であるかどうかをテスト
    assert_equal ['webmaster@wings.msn.to'], email.from
    assert_equal ['masamasa.nukkonuko@gmail.com'], email.to
    assert_equal 'You have been invited by webmaster@wings.msn.to', email.subject
    assert_equal read_fixture('sendmail_confirm').join, email.body.to_s
  end
end
