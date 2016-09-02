class Article < ActiveRecord::Base
  validates  :title, presence: true,length: { minimum: 5, maximum: 50 }
  validates  :description, presence: true,length: { maximum: 150 }
  validates  :tags, presence: true

  belongs_to :user
  has_many :ratings

  belongs_to :pin

  has_and_belongs_to_many :tags

  has_many :likes, as: :likeable


  has_many :positive_votes, -> {where("vote_status = ?", true)}, class_name: 'Vote', 
                                                          dependent:   :destroy
                                                        
  has_many :negative_votes, -> {where("vote_status = ?", false)}, class_name: 'Vote', 
                                                          dependent:   :destroy

  has_many :positive_voters, through: :positive_votes, source: :voter

  has_many :negative_voters, through: :negative_votes, source: :voter


  has_many :comments
  has_many :commenters, through: :comments, source: :user

  has_one :petition

	def all_tags
	  tags.map(&:name).join(", ")
  end

  def all_tags=(tags_name)
    self.tags = tags_name.split(',').map(&:squish).map{|tag_name| Tag.where(name: tag_name).first_or_create}.uniq
  end

   def positive_vote_count
    self.positive_votes.count
  end

  def negative_vote_count
    self.negative_votes.count
  end
  

  def average_rating
    score = 0
    ratings.each do |rating|
      score = score + rating.score
    end
      avg = score.to_f / ratings.count.to_f
  end
  
  def self.get_article_by_pin(id)
    pin = Pin.where(id: id).first
    articles = pin.articles   
  end

  def self.get_article_by_city(id, user)
    city = City.where(id: id).first
    pin_ids = city.pins.map(&:id)
    articles = Article.get_filtered_articles(user).where(pin_id: pin_ids)
  end

  def self.get_article_by_state(id)
    state = State.where(id: id).first
    pin_ids = state.pins.map(&:id)
    articles = Article.where(pin_id: pin_ids)
  end

  def self.get_article_by_country(id)
    country = Country.where(id: id).first
    pin_ids = country.pins.map(&:id)
    articles = Article.where(pin_id: pin_ids)
  end
  
  def self.get_filtered_articles(user)
    users = user.blocked_users + user.blockers
    user_ids = users.map(&:id)
    article = Article.where.not(user_id: user_ids)
  end
end



