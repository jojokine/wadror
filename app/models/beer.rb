class Beer < ActiveRecord::Base
  include RatingAverage

  belongs_to :style
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user

  validates :name, presence: true
  validates :style, presence: true

  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating || 0) }
    return sorted_by_rating_in_desc_order.first(n)
  end

  def to_s
    "#{name} #{brewery.name}"
  end
end
