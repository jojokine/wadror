class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  include RatingAverage
  validates :name, presence: true
  validates :year, numericality: {greater_than_or_equal_to: 1042,
                                  only_integer: true}
  validate :est_in_future

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

  def est_in_future
    if(Date.today.year < year)
      errors.add(:year,"; Establishment year cannot be in the future")
    end
  end

end