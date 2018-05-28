require 'rails_helper'

describe AdUnitsController, type: :controller do
  let!(:ad_unit) { create(:ad_unit) }
  let(:ad_unit_params) do
    {
      title: ad_unit.title,
      description: ad_unit.description,
      click_url_default: ad_unit.click_url_default,
      ad_unit_url: ad_unit.click_url_default,
      active: true,
      ad_format: ad_unit.ad_format,
      aspect_ratio_width: ad_unit.aspect_ratio_width,
      aspect_ratio_height: ad_unit.aspect_ratio_height,
      last_served_at: ad_unit.last_served_at,
      user_id: ad_unit.user.id,
      click_to_action: ad_unit.click_to_action
    }
  end

  before do
    Timecop.freeze(Time.current)
  end

  def verify_ad_unit_json(json, ad_unit)
    expect(json[:id]).to eql ad_unit.id
    expect(json[:title]).to eql ad_unit.title
    expect(json[:description]).to eql ad_unit.description
    expect(json[:click_url_default]).to eql ad_unit.click_url_default
    expect(json[:ad_unit_url]).to eql ad_unit.ad_unit_url
    expect(json[:active]).to eql ad_unit.active
    expect(json[:last_served_at]).to eql ad_unit.last_served_at
    expect(json[:aspect_ratio_width]).to eql ad_unit.aspect_ratio_width
    expect(json[:aspect_ratio_height]).to eql ad_unit.aspect_ratio_height
    expect(json[:ad_format]).to eql ad_unit.ad_format
    expect(json[:user][:id]).to eql ad_unit.user_id
  end

  describe "#create" do
    it "creates a new ad_unit" do
      post :create, params: { ad_unit: ad_unit_params }, format: :json

      expect(response).to be_success

      response_json = parsed_response_json(response)
      ad_unit = AdUnit.last

      verify_ad_unit_json(response_json[:ad_unit], ad_unit)
    end
  end

  describe "#fetch" do
    it "fetches the least recently served ad_unit" do
      get :fetch, params: ad_unit_params, format: :json

      expect(response).to be_success

      response_json = parsed_response_json(response)

      verify_ad_unit_json(response_json[:ad_unit], ad_unit)
    end
  end

  describe "#default" do
    it "fetches default ad_unit" do
      get :default, format: :json

      expect(response).to be_success

      response_json = parsed_response_json(response)

      verify_ad_unit_json(response_json[:ad_unit], ad_unit)
    end
  end
end
