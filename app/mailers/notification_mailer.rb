class NotificationMailer < ActionMailer::Base

   default from: "1519shwetasingh@gmail.com"
	

	def notification_email(emails, article)
	   @article = article
	   mail(to: emails, subject: "Petition Filed For Article #{@article.title}")
    end

    def send_signup_email(user, password)
      @user = user
      @password = password
      mail( :to => @user.email,
      :subject => 'Thanks for signing up for our api app' )
    end
end
