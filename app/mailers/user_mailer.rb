class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(mail_to_user)
    @mail_to_user = mail_to_user
    @time_limit = mail_to_user.activated_at.since(2.hours)
    mail(
      subject: 'アカウント仮作成の確認', 
      to: @mail_to_user.email
    )
  end
end
