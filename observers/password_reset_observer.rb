class PasswordResetObserver < ActiveRecord::Observer
    observe :user
  
    def after_update(user)
      if user.reset_password_token.present?
        UserMailer.reset_password_email(user).deliver_now
      end
    end
  end