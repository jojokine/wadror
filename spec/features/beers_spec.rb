require 'rails_helper'


describe "a new beer" do
  before :each do
    @breweries = ["Koff", "Karjala", "Schlenkerla"]
    year = 1896
    @breweries.each do |brewery_name|
      FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
    end
  end

  it "can be added with correct information " do

    visit new_beer_path
    fill_in('Name', with:'Testiolut')
    click_button "Create Beer"
    expect(page).to have_content "Beer was successfully created."
    expect(page).to have_content "Testiolut"
    expect(Beer.count).to eq(1)
  end


  it "cannot be added without a name" do
    visit new_beer_path
    click_button "Create Beer"
    expect(page).to have_content "Name can't be blank"
    expect(Beer.count).to eq(0)
  end

  BeerClub
  MembershipsController
  BeerClubsController

end