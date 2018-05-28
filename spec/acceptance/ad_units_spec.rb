require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Ad_Units" do
  explanation "A single advertisement that may be served."

  let(:ad_unit_params) do
    {
      title: ad_unit.title,
      description: ad_unit.description,
      click_url_default: ad_unit.click_url_default,
      ad_unit_url: ad_unit.click_url_default,
      active: true,
      user_id: ad_unit.user.id,
      ad_format: AdUnit::FORMAT_IMAGE,
      aspect_ratio_width: 16,
      aspect_ratio_height: 9,
      last_served_at: Time.current,
      call_to_action: ad_unit.call_to_action
    }
  end
  let!(:ad_unit) do
    create :ad_unit,
           :wide,
           ad_format: AdUnit::FORMAT_IMAGE,
           last_served_at: Time.current,
           active: true
  end


  get "/ad_units/default" do
    parameter :ad_unit, :required => true
    parameter :title, "Advertisement title", :scope => :ad_unit
    parameter :description, "Advertisement description", :scope => :ad_unit
    parameter :click_url_default, "Click URL", :scope => :ad_unit
    parameter :ad_unit_url, "Advetisement URL", :scope => :ad_unit
    parameter :active, "Active advertisement", :scope => :ad_unit
    parameter :user_id, "User ID", :scope => :ad_unit
    parameter :ad_format, "Advertisement format", :scope => :ad_unit
    parameter :aspect_ratio_width, "Width of aspect ratio", :scope => :ad_unit
    parameter :aspect_ratio_height, "Height of aspect ratio", :scope => :ad_unit
    parameter :last_served_at, "Time at which ad unit was last served", :scope => :ad_unit


    example "Fetch default ad unit" do
      explanation "Retrieve the default advertisement unit and its metadata."
      do_request(:ad_unit => ad_unit_params)

      status.should == 200
    end
  end

  get "/ad_units/fetch" do
    parameter :ad_unit, :required => true
    parameter :title, "Advertisement title", :scope => :ad_unit
    parameter :description, "Advertisement description", :scope => :ad_unit
    parameter :click_url_default, "Click URL", :scope => :ad_unit
    parameter :ad_unit_url, "Advetisement URL", :scope => :ad_unit
    parameter :active, "Active advertisement", :scope => :ad_unit
    parameter :user_id, "User ID", :scope => :ad_unit
    parameter :ad_format, "Advertisement format", :scope => :ad_unit
    parameter :aspect_ratio_width, "Width of aspect ratio", :scope => :ad_unit
    parameter :aspect_ratio_height, "Height of aspect ratio", :scope => :ad_unit
    parameter :last_served_at, "Time at which ad unit was last served", :scope => :ad_unit

    example "Fetch least recently served ad unit" do
      explanation "Retrieve the least recently served advertisement unit and its metadata."
      do_request(:ad_unit => ad_unit_params)

      status.should == 200
    end
  end

  post "/ad_units" do
    parameter :ad_unit, :required => true
    parameter :title, "Advertisement title", :scope => :ad_unit
    parameter :description, "Advertisement description", :scope => :ad_unit
    parameter :click_url_default, "Click URL", :scope => :ad_unit
    parameter :ad_unit_url, "Advetisement URL", :scope => :ad_unit
    parameter :active, "Active advertisement", :scope => :ad_unit
    parameter :user_id, "User ID", :scope => :ad_unit
    parameter :ad_format, "Advertisement format", :scope => :ad_unit
    parameter :aspect_ratio_width, "Width of aspect ratio", :scope => :ad_unit
    parameter :aspect_ratio_height, "Height of aspect ratio", :scope => :ad_unit
    parameter :last_served_at, "Time at which ad unit was last served", :scope => :ad_unit

    example "Create a new ad unit" do
      explanation "This method creates a new advertisement and stores it in the database."
      do_request(:ad_unit => ad_unit_params)

      status.should == 200
    end
  end
end
