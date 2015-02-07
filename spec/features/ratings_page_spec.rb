require 'rails_helper'

  describe "when ratings exist" do
    let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
    let!(:beer) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
    let!(:user) { FactoryGirl.create :user }
    let!(:rating) {FactoryGirl.create :rating, beer:beer, user:user, score:15 }

    it "page shows count of them" do
      visit ratings_path
      expect(page).to have_content "Number of ratings 1"
    end

    it "page shows them" do
      visit ratings_path
      expect(page).to have_content "iso 3 15"
    end

  end
