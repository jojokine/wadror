class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user
  include RatingAverage
  validates :name, :style, presence: true

  def to_s
    "#{self.name}, #{self.brewery.name}"
  end
end
