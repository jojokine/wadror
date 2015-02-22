module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    avg = ratings.map(&:score).sum.to_f/ratings.count
    if avg.nan?
      0
    else
      avg
    end


  end
end