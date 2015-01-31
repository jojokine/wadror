class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  include RatingAverage
  validates :name, presence: true
  validates :year, numericality: {greater_than_or_equal_to: 1042,
                                  less_than_or_equal_to: 2015,
                                  only_integer: true}

  def to_s
    self.name
  end
  def print_report
    puts self.name
    puts "established in year #{self.year}"
    puts "number of beers #{self.beers.count}"
  end
  def restart
    self.year = 2015
    puts "changed year to #{year}"
  end
end