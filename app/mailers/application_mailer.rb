class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  # layout 'mailer'

  def token_confirm_email(email, opt = {})
    if email
      if opt[:good_id] && opt[:review_id] && opt[:token]
        @str = good_reviews_url(opt[:good_id], opt[:review_id], token: opt[:token])
        mail(to: email, subject: 'Confirm review')
      end
    end
  end
end
