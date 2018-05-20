require 'rails_helper'

describe AdUnitsController, type: :controller do
  let!(:ad_unit) { create(:ad_unit) }
  let(:ad_unit_params) do
    {
      title: ad_unit.title,
      description: ad_unit.description,
      click_url: ad_unit.click_url,
      ad_unit_url: ad_unit.click_url,
      active: true,
      user_id: ad_unit.user.id
    }
  end

  before do
    Timecop.freeze(Time.current)
  end

  def verify_ad_unit_json(json, ad_unit)
    expect(json[:id]).to eql ad_unit.id
    expect(json[:title]).to eql ad_unit.title
    expect(json[:description]).to eql ad_unit.description
    expect(json[:click_url]).to eql ad_unit.click_url
    expect(json[:ad_unit_url]).to eql ad_unit.ad_unit_url
    expect(json[:active]).to eql ad_unit.active
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
      get :fetch, format: :json

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
