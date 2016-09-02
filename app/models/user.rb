class User < ActiveRecord::Base
  validates :auth_token, uniqueness: true
  before_create :generate_authentication_token!

  validates :email, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :products, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :ratings

  has_many :comments
  has_many :commented_articles, through: :comments , source: :article


  has_many :votes, class_name: 'Vote', foreign_key: 'voter_id', dependent: :destroy

  has_many :positive_votes, -> {where("vote_status = ?", true)}, class_name: 'Vote',
                                                          dependent:   :destroy,
                                                          foreign_key: 'voter_id'

  has_many :negative_votes, -> {where("vote_status = ?", false)}, class_name: 'Vote',
                                                          dependent:   :destroy,
                                                          foreign_key: 'voter_id'

  has_many :positive_voted_articles, through: :positive_votes, source: :article

  has_many :negative_voted_articles, through: :negative_votes, source: :article



  has_many :likings, -> {where("like_status = ?", true)}, class_name: 'Like',
                                                          foreign_key: 'liker_id', 
                                                          dependent:   :destroy
  has_many :liked_users, through: :likings , source: :user  


  has_many :dislikings, -> {where("like_status = ?", false)}, class_name: 'Like', 
                                                              foreign_key: 'liker_id', 
                                                              dependent:   :destroy
  has_many :disliked_users, through: :dislikings, source: :user 


  
  has_many :likes, -> {where("like_status = ?", true)}
  has_many :my_likers, through: :likes , source: :liker

  has_many :dislikes, -> {where("like_status = ?", false)}, class_name: 'Like'
  has_many :my_dislikers, through: :dislikes , source: :liker


  has_many :blockings, class_name: 'Block', foreign_key: 'blocker_id', dependent:  :destroy
  has_many :blocked_users, through: :blockings , source: :user
  

  has_many :blocks, class_name: 'Block', foreign_key: 'user_id', dependent:  :destroy
  has_many :blockers, through: :blocks, source: :blocker

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

end







