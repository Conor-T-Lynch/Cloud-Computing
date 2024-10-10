class UserMailer < ApplicationMailer
    def reset_password_email(user)
      @user = user
      @reset_url = edit_user_password_url(@user, reset_password_token: @user.reset_password_token)
      mail(to: @user.email, subject: 'Reset your password')
    end
  end