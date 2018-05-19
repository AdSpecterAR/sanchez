require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Ad_Units" do
  explanation "A single advertisement that may be served."

  let!(:user) { create(:user) }
  let!(:ad_unit) { create(:ad_unit, user: user) }
  let(:ad_unit_params) do
    {
      title: ad_unit.title,
      description: ad_unit.description,
      click_url: ad_unit.click_url,
      ad_unit_url: ad_unit.click_url,
      active: true,
      user_id: user.id
    }
  end


  get "/ad_units/default" do
    parameter :ad_unit, :required => true
    parameter :title, "Advertisement title", :scope => :ad_unit
    parameter :description, "Advertisement description", :scope => :ad_unit
    parameter :click_url, "Click URL", :scope => :ad_unit
    parameter :ad_unit_url, "Advetisement URL", :scope => :ad_unit
    parameter :active, "Active advertisement", :scope => :ad_unit
    parameter :user_id, "User ID", :scope => :ad_unit

    example "Fetch default advertisement" do
      explanation "Retrieve the default advertisement unit and its metadata."
      do_request(:ad_unit => ad_unit_params)

      status.should == 200
    end
  end

  post "/ad_units" do
    parameter :ad_unit, :required => true
    parameter :title, "Advertisement title", :scope => :ad_unit
    parameter :description, "Advertisement description", :scope => :ad_unit
    parameter :click_url, "Click URL", :scope => :ad_unit
    parameter :ad_unit_url, "Advetisement URL", :scope => :ad_unit
    parameter :active, "Active advertisement", :scope => :ad_unit
    parameter :user_id, "User ID", :scope => :ad_unit

    example "Create a new ad_unit" do
      explanation "This method creates a new advertisement and stores it in the database."
      do_request(:ad_unit => ad_unit_params)

      status.should == 200
    end
  end
end
