class UserMailer < ApplicationMailer
  default from: 'from@example.com'

  def reset_password_instructions(user)
    @user = user  # User.findは不要、直接userを渡す
    @url  = edit_password_reset_url(@user.reset_password_token)  # URLを渡す
    mail(to: @user.email,
         subject: t('defaults.password_reset'))  # メール件名
  end
end
