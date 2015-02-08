require 'rails_helper'

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq"Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password" do
    user = User.create username:"Pekka", password:"Se1", password_confirmation:"Se1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with letters-only password" do
    user = User.create username:"Pekka", password:"Secret", password_confirmation:"Secret"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(best)
    end

  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create :user, username:"Testuser2" }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer, style: 'lager')
      FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_style).to eq('lager')
    end

    it "is the one with highest average rating if several rated" do
      c_beers_w_styles_n_ratings(10, 20, 15, 7, 9, user, "lager")
      c_beers_w_styles_n_ratings(30, 30, 30, 30, 30, user, "pale ale")
      c_beers_w_styles_n_ratings(5, 4, 10, 11, 4, user, "pilssiolut")
      c_beers_w_styles_n_ratings(10, 10, 10, 10, 10, user2, "pale ale")

      expect(user.favorite_style).to eq('pale ale')
    end


  end

  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create :user, username:"Testuser2" }
    let!(:brewery){FactoryGirl.create(:brewery, name:'brewery', year:1998)}
    let!(:brewery2){FactoryGirl.create(:brewery, name:'brewery2', year:1998)}

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only rated if only one rating" do
      brewery = FactoryGirl.create(:brewery, name:'brewery', year:1998 )
      beer = FactoryGirl.create(:beer, brewery:brewery)
      FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_brewery).to eq(brewery)
    end

    it "is the one with highest average rating if several rated" do
      c_beers_w_breweries_n_ratings(10, 20, 15, 7, 9, user, brewery2)
      c_beers_w_breweries_n_ratings(30, 30, 30, 30, 30, user, brewery)
      c_beers_w_breweries_n_ratings(30, 30, 30, 30, 30, user2, brewery2)

      expect(user.favorite_brewery).to eq(brewery)
    end

  end

  def create_beer_with_rating(score, user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def c_beer_w_rating_n_style(score, user, style)
    beer = FactoryGirl.create(:beer, style:style)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def c_beer_w_brewery_n_style(score, user, brewery)
    beer = FactoryGirl.create(:beer, brewery:brewery)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def c_beers_w_styles_n_ratings(*scores, user, style)
    scores.each do |score|
      c_beer_w_rating_n_style(score, user, style)
    end
  end

  def c_beers_w_breweries_n_ratings(*scores, user, brewery)
    scores.each do |score|
      c_beer_w_brewery_n_style(score, user, brewery)
    end
  end

  def create_beers_with_ratings(*scores, user)
    scores.each do |score|
      create_beer_with_rating(score, user)
    end
  end

end