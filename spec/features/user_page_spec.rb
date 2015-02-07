require 'rails_helper'

describe "User page" do

  let!(:brewery) { FactoryGirl.create :brewery, name:"Hoegaarden" }

  let!(:beer) { FactoryGirl.create :beer, name:"Hoegaarden", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Other beer", brewery:brewery }

  let!(:user) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user, username:"Testuser2" }

  let!(:rating) {FactoryGirl.create :rating, beer:beer, user:user, score:30 }
  let!(:rating2) {FactoryGirl.create :rating, beer:beer2, user:user, score:40 }

  it "should have users own ratings" do
    visit user_path(user)
    expect(page).to have_content 'Hoegaarden'
    expect(page).to have_content 'Other beer'

  end

  it "should not have other users ratings" do
    visit user_path(user2)
    expect(page).not_to have_content 'Hoegaarden'
    expect(page).not_to have_content 'Other beer'

  end

  it "should delete users own ratings" do
    sign_in username:"Pekka", password:"Foobar1"

    expect(page).to have_content 'Hoegaarden'
    expect(user.ratings.count).to eq(2)

    page.find('li', :text => "Hoegaarden").click_link('delete')

    expect(page).not_to have_content 'Hoegaarden'
    expect(user.ratings.count).to eq(1)
  end



end
