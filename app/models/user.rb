class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
            length: { minimum: 3 , maximum: 15}

  validates :password, format: { :with => /(?=.*[A-Z])(?=.*[0-9]).{4,}/}

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships


  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    favorite = ''
    ratings.each do |rating|
      if style_average(rating.beer.style) > style_average(favorite)
        favorite = rating.beer.style
      end
    end
    favorite
  end

  def favorite_brewery
    return nil if ratings.empty?
    favorite = nil
    ratings.each do |rating|
      if brewery_average(rating.beer.brewery) > brewery_average(favorite)
        favorite = rating.beer.brewery
      end
    end
    favorite
  end

  def brewery_average(brewery)
    return 0 if brewery.nil?
    breweryratings = []
    ratings.each do |rating|
      if rating.beer.brewery.eql? brewery
        breweryratings.append rating.score
      end
    end
    breweryratings.sum / breweryratings.size.to_f
  end

  def style_average(style)
    return 0 if style.empty?
    styleratings = []
    ratings.each do |rating|
      if rating.beer.style.eql? style
        styleratings.append rating.score
      end
    end
    styleratings.sum / styleratings.size.to_f
  end

end
