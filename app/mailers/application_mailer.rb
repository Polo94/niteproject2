class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  # layout 'mailer'

  def token_confirm_email(email)
    if email
      mail(to: email, subject: 'Confirm review')
    end
  end
end
