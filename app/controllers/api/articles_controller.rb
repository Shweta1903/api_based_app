class Api::ArticlesController < ApplicationController
 respond_to :json
 before_action :authenticate_with_token!, except: [:show, :index, :location_based]

  def index
    respond_with Article.get_filtered_articles(current_user)
  end
  
	def show
	  article = Article.where(id: params[:id]).includes(:tags, :comments, :negative_votes, :positive_votes).first
    if article.present?
      render json: {article: article, comments: article.comments, positive_vote_count: article.positive_votes.count, negative_votes_count: article.negative_votes.count, comments_count: article.comments.count, rating: article.average_rating}
    else
      render json: {message: 'No Article Found with this Id'}
	  end
  end

  def my_favourite_articles
    articles = current_user.articles + current_user.positive_voted_articles + current_user.commented_articles
    articles = articles.flatten.uniq
    render json: articles, status: 201
  end

  def article_ratings
    rating = Rating.where(user_id: current_user.id, article_id: params[:rating][:article_id]).first_or_initialize
    rating.score = params[:rating][:score]
    if rating.save
      render json: {success: true, rating: rating}
    else
      render json: {message: 'No Rating Found with this Id'}
    end
  end


  def create
    article = current_user.articles.new(article_params)
    if params[:location].present?
      pin = save_locations_and_get_pin(params[:location])
      article.pin_id = pin.id    
    end
    if article.save
      render json: article, status: 201
    else
      render json: { errors: article.errors }, status: 422
    end
  end

  def location_based
    if params[:type] == "country"
      articles = Article.get_article_by_country(params[:id])
    elsif params[:type] == "state"
      articles = Article.get_article_by_state(params[:id])
    elsif params[:type] == "city"
      articles = Article.get_article_by_city(params[:id])
    elsif params[:type] == "pin"
      articles = Article.get_article_by_pin(params[:id])
    else
      articles = Article.all
    end
     render json: articles, status: 201 
  end

                                                                                
  # def create
  #   article = current_user.articles.new(article_params)
  #   if article.save
  #     render json: article, status: 201
  #   else
  #     render json: { errors: article.errors }, status: 422
  #   end
  # end

	def my_articles
	  articles = current_user.articles
	  render json: articles, status: 201
	end

  def location_based
    if params[:type] == "country"
      articles = Article.get_article_by_country(params[:id])
    elsif params[:type] == "state"
      articles = Article.get_article_by_state(params[:id])
    elsif params[:type] == "city"
      p "==================================="
      articles = Article.get_article_by_city(params[:id], current_user)
    elsif params[:type] == "pin"
      articles = Article.get_article_by_pin(params[:id])
    else
      articles = Article.all
    end              
    render json: articles, status: 201
  end
                                                                                                 
private

  def article_params
    params.require(:article).permit(:title, :description, :all_tags)
  end

  def save_locations_and_get_pin (location)
    country = Country.where(name: location[:country]).first_or_create if location[:country].present?
    state = State.where(name: location[:state], country_id: country.id).first_or_create if location[:state].present?
    city = City.where(name: location[:city], state_id: state.id).first_or_create if location[:city].present?
    pin = Pin.where(name: location[:pin], city_id: city.id).first_or_create if location[:pin].present?
    return pin
  end
end




 



