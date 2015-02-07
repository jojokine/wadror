require 'rails_helper'

describe Beer do

  it "is saved with proper name and style" do
    beer = Beer.create name:"Olut", style:"style"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    beer = Beer.create style:"style"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"Olut"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

end