class Petition < ActiveRecord::Base
  belongs_to :article


  # def self.check_petition
  # 	NotificationMailer.notification_email("shweta.singh@evontech.com").deliver
  # end

  def self.check_petition(article)
    if (!article.petition.present? && (article.positive_votes.count > 1) && (article.comments.count > 1))
  		petition = Petition.create(article_id: article.id)
  		users = article.positive_voters + article.commenters + [article.user]
  		emails = users.map(&:email).flatten.uniq
      NotificationMailer.notification_email(emails, article).deliver_later
    end
  end
end

